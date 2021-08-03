use Ozeki::Libs::Rest::Configuration;
use Ozeki::Libs::Rest::MessageApi;
 
my $configuration = new Ozeki::Libs::Rest::Configuration();
$configuration->{ Username } = "http_user";
$configuration->{ Password } = "qwe123";
$configuration->{ ApiUrl } = "http://127.0.0.1:9509/api";
 
my $api = new Ozeki::Libs::Rest::MessageApi($configuration);
 
my $result = $api->DownloadIncoming();
 
print($result->stringify, "\n");
 
foreach my $message (@{ $result->{ messages } }) {
    print($message->stringify, "\n");
}
