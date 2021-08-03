use Ozeki::Libs::Rest::Configuration;
use Ozeki::Libs::Rest::MessageApi;
use Ozeki::Libs::Rest::Message;
use DateTime;
 
my $configuration = new Ozeki::Libs::Rest::Configuration();
$configuration->{ Username } = "http_user";
$configuration->{ Password } = "qwe123";
$configuration->{ ApiUrl } = "http://127.0.0.1:9509/api";
 
my $msg = new Ozeki::Libs::Rest::Message();
$msg->{ ToAddress } = "+36201111111";
$msg->{ Text } = "Hello world!";
$msg->{ TimeToSend } = DateTime->new(year=>2021,month=>7,day=>2,hour=>16,minute=>0,second=>0)->stringify;
 
my $api = new Ozeki::Libs::Rest::MessageApi($configuration);
 
my $result = $api->Send($msg);
 
print($result->stringify);
