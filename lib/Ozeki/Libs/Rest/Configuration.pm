package Ozeki::Libs::Rest::Configuration;

sub new {
    $class = shift;
    $self = {
        Username => shift,
        Password => shift,
        ApiUrl => shift
    };
    bless $self, $class;
    return $self;
}

1;