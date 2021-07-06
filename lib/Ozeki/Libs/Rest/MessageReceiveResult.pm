package Ozeki::Libs::Rest::MessageReceiveResult;

sub new {
    my $class = shift;
    my $self = {
        folder => shift,
        limit => shift,
        @messages => []
    };
    bless ($self, $class);
    return $self;
}

#Function to get a string representation of the object
sub stringify {
    my ($self) = @_;
    my $messagesNum = @{ $self->{ messages } };
    return "Messages count: ".$messagesNum.".";
}

1;