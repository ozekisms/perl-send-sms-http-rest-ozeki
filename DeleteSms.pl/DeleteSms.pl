use Ozeki::Libs::Rest::Configuration;
use Ozeki::Libs::Rest::MessageApi;
use Ozeki::Libs::Rest::Message;
use Ozeki::Libs::Rest::Folder;
 
my $configuration = new Ozeki::Libs::Rest::Configuration();
$configuration->{ Username } = "http_user";
$configuration->{ Password } = "qwe123";
$configuration->{ ApiUrl } = "http://127.0.0.1:9509/api";
 
my $msg = new Ozeki::Libs::Rest::Message();
#You have to change this ID attribute to delete a certain message
$msg->{ ID } = "19fed2a2-da46-11eb-8339-ffacbeab4160";
 
my $api = new Ozeki::Libs::Rest::MessageApi($configuration);
 
my $result = $api->Delete(Ozeki::Libs::Rest::Folder->Inbox, $msg);
 
print($result);
