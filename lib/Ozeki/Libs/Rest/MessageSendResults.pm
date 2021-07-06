package Ozeki::Libs::Rest::MessageSendResults;

sub new {
    my $class = shift;
    my $self = {
        totalCount => shift,
        successCount => shift,
        failedCount => shift,
        @results => []
    };
    bless ($self, $class);
    return $self;
}

#Function to get a string representation of the object
sub stringify {
    my ($self) = @_;
    return "Total: ".$self->{ totalCount }.". Success: ".$self->{ successCount }.". Failed: ".$self->{ failedCount }.".";
}

1;