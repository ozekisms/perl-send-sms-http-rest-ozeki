package Ozeki::Libs::Rest::Message;

use DateTime;
use UUID::Generator::PurePerl;

sub new {
    my $class = shift;
    my $self = {
        ID => UUID::Generator::PurePerl->new()->generate_v1()->as_string(),
        FromConnection => shift,
        FromAddress => shift,
        FromStation => shift,
        ToConnection => shift,
        ToAddress => shift,
        ToStation => shift,
        Text => shift,
        CreateDate => DateTime->now->stringify,
        ValidUntil => (DateTime->now)->add(days => 7)->stringify,
        TimeToSend => DateTime->now->stringify,
        IsSubmitReportRequested => 1,
        IsDeliveryReportRequested => 1,
        IsViewReportRequested => 1,
        Tags => ()
    };
    bless ($self, $class);
    return $self;
}

#Function to add a new tag to your message
sub addTag {
    my ($self, $key, $value) = @_;
    @{ $self->{ Tags } }{$key} = $value;
    return $self;
}

#Function to turn the tags into JSON string
sub getTags {
    my ($self) = @_;
    my $tags = "[";
    for my $key ( keys %{ $self->{ Tags } } ) {
        my $value = %{ $self->{ Tags } }{$key};
        if ($tags eq "[") {
            $tags = "${tags}{${key}: ${value}}";
        } else {
            $tags = "${tags},{${key}: ${value}}";
        }
    }
    $tags = "${tags}]";
    return $tags;
}

#Function to turn the object into JSON string
sub getJSON {
    my ($self) = @_;
    my $json = "{";
    if ($self->{ ID } ne "") {
        my $message_id = $self->{ ID };
        $json = "${json}\"message_id\": \"${message_id}\"";
    }
    if ($self->{ FromConnection } ne "") {
        my $from_connection = $self->{ FromConnection };
        $json = "${json},\"from_connection\": \"${from_connection}\"";
    }
    if ($self->{ FromAddress } ne "") {
        my $from_address = $self->{ FromAddress };
        $json = "${json},\"from_address\": \"${from_address}\"";
    }
    if ($self->{ FromStation } ne "") {
        my $from_station = $self->{ FromStation };
        $json = "${json},\"from_station\": \"${from_station}\"";
    }
    if ($self->{ ToConnection } ne "") {
        my $to_connection = $self->{ ToConnection };
        $json = "${json},\"to_connection\": \"${to_connection}\"";
    }
    if ($self->{ ToAddress } ne "") {
        my $to_address = $self->{ ToAddress };
        $json = "${json},\"to_address\": \"${to_address}\"";
    }
    if ($self->{ ToStation } ne "") {
        my $to_station = $self->{ ToStation };
        $json = "${json},\"to_station\": \"${to_station}\"";
    }
    if ($self->{ Text } ne "") {
        my $text = $self->{ Text };
        $json = "${json},\"text\": \"${text}\"";
    }
    if ($self->{ CreateDate } ne "") {
        my $create_date = $self->{ CreateDate };
        $json = "${json},\"create_date\": \"${create_date}\"";
    }
    if ($self->{ ValidUntil } ne "") {
        my $valid_until = $self->{ ValidUntil };
        $json = "${json},\"valid_until\": \"${valid_until}\"";
    }
    if ($self->{ TimeToSend } ne "") {
        my $time_to_send = $self->{ TimeToSend };
        $json = "${json},\"time_to_send\": \"${time_to_send}\"";
    }
    if ($self->{ IsSubmitReportRequested }) {
        my $submit_report_requested = $self->{ IsSubmitReportRequested };
        $json = "${json},\"submit_report_requested\": true";
    } else {
        my $submit_report_requested = $self->{ IsSubmitReportRequested };
        $json = "${json},\"submit_report_requested\": false";
    }
    if ($self->{ IsDeliveryReportRequested }) {
        my $delivery_report_requested = $self->{ IsDeliveryReportRequested };
        $json = "${json},\"delivery_report_requested\": true";
    } else {
        my $delivery_report_requested = $self->{ IsDeliveryReportRequested };
        $json = "${json},\"delivery_report_requested\": false";
    }
    if ($self->{ IsViewReportRequested }) {
        my $view_report_requested = $self->{ IsViewReportRequested };
        $json = "${json},\"view_report_requested\": true";
    } else {
        my $view_report_requested = $self->{ IsViewReportRequested };
        $json = "${json},\"view_report_requested\": false";
    }
    my $tags = $self->getTags();
    $json = "${json},\"tags\": ${tags}";
    $json = "${json}}";
}

#Function to get a string representation of the object
sub stringify {
    my ($self) = @_;
    return $self->{ FromAddress }."->".$self->{ ToAddress }." '".$self->{ Text }."'";
}

1;