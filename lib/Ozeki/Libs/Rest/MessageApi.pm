package Ozeki::Libs::Rest::MessageApi;

our $VERSION = 1.0;

#Modules
use Ozeki::Libs::Rest::Message;
use Ozeki::Libs::Rest::MessageSendResult;
use Ozeki::Libs::Rest::MessageDeleteResult;
use Ozeki::Libs::Rest::MessageMarkResult;
use Ozeki::Libs::Rest::MessageSendResults;
use Ozeki::Libs::Rest::MessageReceiveResult;
use Ozeki::Libs::Rest::DeliveryStatus;
use Ozeki::Libs::Rest::Folder;

#Dependencies
require LWP::UserAgent;
use HTTP::Request;
use MIME::Base64;
use JSON;

sub new {
    my $class = shift;
    my $self = {
        _configuration => shift
    };
    bless $self, $class;
    return $self;
}

#Function to create the Basic authorization header
sub createauthorization_header {
    my ($self, $Username, $Password) = @_;
    my $Username_Password = "${Username}:${Password}";
    my $Username_Password_encoded = encode_base64($Username_Password);
    return "Basic ${Username_Password_encoded}";
}

#Function to create request body to send sms messages
sub create_request_body {
    my ($self, @messages) = @_;
    my $msgs = "";
    my $msg;
    for(my $i = 0; $i <= $#messages; $i++){
        $msg = $messages[$i]->getJSON;
        if ($msgs ne "") {
            $msgs = "${msgs}, ${msg}";
        } else {
            $msgs = "${msg}";
        }
    }
    return ("{\"messages\": [$msgs]}");
}

#Function to create request body to delete and send messages
sub create_request_body_to_manipulate {
    my ($self, $folder, @messages) = @_;
    my $msgs = "";
    my $msg;
    for(my $i = 0; $i <= $#messages; $i++){
        $id = $messages[$i]->{ ID };
        if ($msgs ne "") {
            $msgs = "${msgs}, \"${id}\"";
        } else {
            $msgs = "\"${id}\"";
        }
    }
    return ("{\"folder\":\"$folder\",\"message_ids\":[$msgs]}");
}

#Fucntion to create an url to send messages
sub create_uri_to_send_sms {
    my ($self, $url) = @_;
    my $baseUrl = (split '\?', $url)[0];
    return $baseUrl."?action=sendmsg";
}

#Fucntion to create an url to delete messages
sub create_uri_to_delete_sms {
    my ($self, $url) = @_;
    my $baseUrl = (split '\?', $url)[0];
    return $baseUrl."?action=deletemsg";
}

#Fucntion to create an url to mark messages
sub create_uri_to_mark_sms {
    my ($self, $url) = @_;
    my $baseUrl = (split '\?', $url)[0];
    return $baseUrl."?action=markmsg";
}

#Fucntion to create an url to receive messages
sub create_uri_to_receive_sms {
    my ($self, $url, $folder) = @_;
    my $baseUrl = (split '\?', $url)[0];
    return $baseUrl."?action=receivemsg&folder=".$folder;
}

#Fucntion to send sms messages
sub Send {
    my ($self, @messages) = @_;
    my $authorization_header = $self->createauthorization_header($self->{ _configuration }->{ Username }, $self->{ _configuration }->{ Password });
    my $request_body = $self->create_request_body(@messages);
    my $result = $self->get_response_send
    ($self->do_request_post($self->create_uri_to_send_sms($self->{ _configuration }->{ ApiUrl }), $request_body, $authorization_header));
    if ($result->{ totalCount } eq "1") {
        return $result->{ results }[0];
    } else {
        return $result;
    }
}

#Fucntion to delete sms messages
sub Delete {
    my ($self, $folder, @messages) = @_;
    my $authorization_header = $self->createauthorization_header($self->{ _configuration }->{ Username }, $self->{ _configuration }->{ Password });
    my $request_body = $self->create_request_body_to_manipulate($folder, @messages);
    my $result =  $self->get_response_manipulate($self->do_request_post($self->create_uri_to_delete_sms($self->{ _configuration }->{ ApiUrl }), $request_body, $authorization_header), @messages);
    if ($result->{ totalCount } == 1 && $result->{ totalCount } == $result->{ successCount }) {
        return 1;
    } elsif ($result->{ totalCount } == 1 && $result->{ totalCount } != $result->{ successCount }) {
        return 0;
    } else {
        return $result;
    }
}

#Fucntion to mark sms messages
sub Mark {
    my ($self, $folder, @messages) = @_;
    my $authorization_header = $self->createauthorization_header($self->{ _configuration }->{ Username }, $self->{ _configuration }->{ Password });
    my $request_body = $self->create_request_body_to_manipulate($folder, @messages);
    my $result = $self->get_response_manipulate($self->do_request_post($self->create_uri_to_mark_sms($self->{ _configuration }->{ ApiUrl }), $request_body, $authorization_header), @messages);
    if ($result->{ totalCount } == 1 && $result->{ totalCount } == $result->{ successCount }) {
        return 1;
    } elsif ($result->{ totalCount } == 1 && $result->{ totalCount } != $result->{ successCount }) {
        return 0;
    } else {
        return $result;
    }
}

#Fucntion to receive sms messages
sub DownloadIncoming {
    my ($self) = @_;
    my $authorization_header = $self->createauthorization_header($self->{ _configuration }->{ Username }, $self->{ _configuration }->{ Password });
    return $self->get_response_receive($self->do_request_get($self->create_uri_to_receive_sms($self->{ _configuration }->{ ApiUrl }, Ozeki::Libs::Rest::Folder->Inbox), $authorization_header));
}

#Function to send a post request
sub do_request_post {
    my ($self, $url, $request_body, $authorization_header) = @_;
    my $headers = ["Content-Length" => length $request_body, "Content-Type" => "application/json; charset=utf8", "Authorization" => $authorization_header];
    my $request = HTTP::Request->new('POST', $url, $headers, $request_body);
    my $user_agent = LWP::UserAgent->new();
    my $response = $user_agent->request($request);
    if ($response->is_success) {
        return $response->decoded_content;
    } else {
        print STDERR $response->status_line, "\n";
    }
}

#Function to send a get request
sub do_request_get {
    my ($self, $url, $authorization_header) = @_;
    my $headers = ["Content-Type" => "application/json", "Authorization" => $authorization_header];
    my $request = HTTP::Request->new('GET', $url, $headers);
    my $user_agent = LWP::UserAgent->new();
    my $response = $user_agent->request($request);
    if ($response->is_success) {
        return $response->decoded_content;
    } else {
        print STDERR $response->status_line, "\n";
    }
}

#Function to get the data from the response : Send()
sub get_response_send {
    my ($self, $response) = @_;
    my $json = decode_json($response);
    my $data = $json->{ data };
    my $response_msg = $json->{ response_msg };
    my $results = new Ozeki::Libs::Rest::MessageSendResults();
    $results->{ totalCount } = $data->{ total_count };
    $results->{ successCount } = $data->{ success_count };
    $results->{ failedCount } = $data->{ failed_count };
    my $length = $data->{ total_count } - 1;
    for my $i (0..$length) {
        $message = $data->{ messages }[$i];
        my $msg = new Ozeki::Libs::Rest::Message();
        my $result;
        if ($message->{ message_id } ne " ") {
            $msg->{ ID } = $message->{ message_id };
        }
        if ($message->{ from_connection } ne " ") {
            $msg->{ FromConnection } = $message->{ from_connection };
        }
        if ($message->{ from_address } ne " ") {
            $msg->{ FromAddress } = $message->{ from_address };
        }
        if ($message->{ from_station } ne " ") {
            $msg->{ FromStation } = $message->{ from_station };
        }
        if ($message->{ to_connection } ne " ") {
            $msg->{ ToConnection } = $message->{ to_connection };
        }
        if ($message->{ to_address } ne " ") {
            $msg->{ ToAddress } = $message->{ to_address };
        }
        if ($message->{ to_station } ne " ") {
            $msg->{ ToStation } = $message->{ to_station };
        }
        if ($message->{ text } ne " ") {
            $msg->{ Text } = $message->{ text };
        }
        if ($message->{ submit_report_requested }) {
            $msg->{ IsSubmitReportRequested } = 1;
        } else {
            $msg->{ IsSubmitReportRequested } = 0;
        }
        if ($message->{ delivery_report_requested }) {
            $msg->{ IsDeliveryReportRequested } = 1;
        } else {
            $msg->{ IsDeliveryReportRequested } = 0;
        }
        if ($message->{ view_report_requested }) {
            $msg->{ IsViewReportRequested } = 1;
        } else {
            $msg->{ IsViewReportRequested } = 0;
        }
        my @tags = $message->{ tags };
        my $length_tags = @ { $message->{ tags } } - 1;
        for my $i (0..$length_tags) {
            my $key = $message->{ tags }[$i]->{ name };
            my $value = $message->{ tags }[$i]->{ value };
            $msg->addTag($key, $value);
        }
        if ($message->{ status } eq "SUCCESS") {
            $result = new Ozeki::Libs::Rest::MessageSendResult($msg, Ozeki::Libs::Rest::DeliveryStatus->Success, $response_msg);
            push @{ $results->{ results } }, $result;
        } else {
            $result = new Ozeki::Libs::Rest::MessageSendResult($msg, Ozeki::Libs::Rest::DeliveryStatus->Failed, $response_msg);
            push @{ $results->{ results } }, $result;
        }
    }
    return $results;
}

#Function to get the data from the response : Delete(), Mark()
sub get_response_manipulate {
    my ($self, $response, @messages) = @_;
    my $json = decode_json($response);
    my $data = $json->{ data };
    my $response_msg = $json->{ response_msg };
    my $folder = $data->{ folder };
    my @success = [];
    my @failed = [];
    my $result = new Ozeki::Libs::Rest::MessageDeleteResult($folder);
    my $length = @ { $data->{ message_ids } } - 1;
    foreach (@messages) {
        my $message = $_;
        my $success = 0;
        for my $j (0..$length) { 
            my $msg = $data->{ message_ids }[$j];
            if ($message->{ ID } eq $msg) {
                $success = 1;
            }
        }
        if ($success) {
            push @{ $result->{ messageIdsRemoveSucceeded } }, $message->{ ID };
            $result->{ totalCount } += 1;
            $result->{ successCount } += 1;
        } else {
            push @{ $result->{ messageIdsRemoveFailed } }, $message->{ ID };
            $result->{ totalCount } += 1;
            $result->{ failedCount } += 1;
        }
    }
    return $result;
}

#Function to get the data from the response : DownloadIncoming()
sub get_response_receive {
    my ($self, $response) = @_;
    my $json = decode_json($response);
    my $data = $json->{ data };
    my $folder = $data->{ folder }; 
    my $limit = $data->{ limit };
    my $result = new Ozeki::Libs::Rest::MessageReceiveResult($folder, $limit);
    my $length = @ { $data->{ data } } - 1;
    for my $i (0..$length) {
        $message = $data->{ data }[$i];
        my $msg = new Ozeki::Libs::Rest::Message();
        if ($message->{ message_id } ne " ") {
            $msg->{ ID } = $message->{ message_id };
        }
        if ($message->{ from_connection } ne " ") {
            $msg->{ FromConnection } = $message->{ from_connection };
        }
        if ($message->{ from_address } ne " ") {
            $msg->{ FromAddress } = $message->{ from_address };
        }
        if ($message->{ from_station } ne " ") {
            $msg->{ FromStation } = $message->{ from_station };
        }
        if ($message->{ to_connection } ne " ") {
            $msg->{ ToConnection } = $message->{ to_connection };
        }
        if ($message->{ to_address } ne " ") {
            $msg->{ ToAddress } = $message->{ to_address };
        }
        if ($message->{ to_station } ne " ") {
            $msg->{ ToStation } = $message->{ to_station };
        }
        if ($message->{ text } ne " ") {
            $msg->{ Text } = $message->{ text };
        }
        if ($message->{ submit_report_requested }) {
            $msg->{ IsSubmitReportRequested } = 1;
        } else {
            $msg->{ IsSubmitReportRequested } = 0;
        }
        if ($message->{ delivery_report_requested }) {
            $msg->{ IsDeliveryReportRequested } = 1;
        } else {
            $msg->{ IsDeliveryReportRequested } = 0;
        }
        if ($message->{ view_report_requested }) {
            $msg->{ IsViewReportRequested } = 1;
        } else {
            $msg->{ IsViewReportRequested } = 0;
        }
        my @tags = $message->{ tags };
        my $length_tags = @ { $message->{ tags } } - 1;
        for my $i (0..$length_tags) {
            my $key = $message->{ tags }[$i]->{ name };
            my $value = $message->{ tags }[$i]->{ value };
            $msg->addTag($key, $value);
        }
        push @{ $result->{ messages } }, $msg;
    }
    $self->Delete(Ozeki::Libs::Rest::Folder->Inbox, @{ $result->{ messages } });
    return $result;
}

1;