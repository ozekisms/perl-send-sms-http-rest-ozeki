use Ozeki::Libs::Rest::Configuration;
use Ozeki::Libs::Rest::MessageApi;
use Ozeki::Libs::Rest::Message;
 
my $configuration = new Ozeki::Libs::Rest::Configuration();
$configuration->{ Username } = "http_user";
$configuration->{ Password } = "qwe123";
$configuration->{ ApiUrl } = "http://127.0.0.1:9509/api";
 
my $msg1 = new Ozeki::Libs::Rest::Message();
$msg1->{ ToAddress } = "+36201111111";
$msg1->{ Text } = "Hello world 1";
 
my $msg2 = new Ozeki::Libs::Rest::Message();
$msg2->{ ToAddress } = "+36202222222";
$msg2->{ Text } = "Hello world 2";
 
my $msg3 = new Ozeki::Libs::Rest::Message();
$msg3->{ ToAddress } = "+36203333333";
$msg3->{ Text } = "Hello world 3";
 
my $api = new Ozeki::Libs::Rest::MessageApi($configuration);
 
my $result = $api->Send(( $msg1, $msg2, $msg3 ));
 
print($result->stringify);
