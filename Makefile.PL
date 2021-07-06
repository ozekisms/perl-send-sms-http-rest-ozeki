use ExtUtils::MakeMaker;

WriteMakefile( 
	'NAME'		=> 'Ozeki-Libs-Rest',
	'DISTNAME'	  => 'Ozeki-Libs-Rest',
	'VERSION_FROM' => 'lib/Ozeki/Libs/Rest/Configuration.pm',
	($] >= 5.005 ? 
		(
			ABSTRACT	=> 'This library helps you to send SMS messages with the Ozeki SMS Gateway using Perl.',
			AUTHOR		=> 'Zsolt Ardai <https://zsoltardai.github.io/>',
			META_MERGE	=> {
				resources  => {
					repository => 'https://github.com/zsoltardai/Ozeki-Libs-Rest',
				}
			}
		) 
		: 
		()
	),
	'dist' => { COMPRESS=>"gzip", SUFFIX=>"gz" },
	'INSTALLDIRS'	=> 'perl',

	PM =>	($] > 5.010 ?
		{
			'lib/Ozeki/Libs/Rest/Configuration.pm'	=> '$(INST_LIBDIR)/Ozeki/Libs/Rest/Configuration.pm',
            'lib/Ozeki/Libs/Rest/Message.pm'	=> '$(INST_LIBDIR)/Ozeki/Libs/Rest/Message.pm',
            'lib/Ozeki/Libs/Rest/MessageApi.pm'	=> '$(INST_LIBDIR)/Ozeki/Libs/Rest/MessageApi.pm',
            'lib/Ozeki/Libs/Rest/Folder.pm'	=> '$(INST_LIBDIR)/Ozeki/Libs/Rest/Folder.pm',
            'lib/Ozeki/Libs/Rest/DeliveryStatus.pm'	=> '$(INST_LIBDIR)/Ozeki/Libs/Rest/DeliveryStatus.pm',
            'lib/Ozeki/Libs/Rest/MessageDeleteResult.pm'	=> '$(INST_LIBDIR)/Ozeki/Libs/Rest/MessageDeleteResult.pm',
            'lib/Ozeki/Libs/Rest/MessageMarkResult.pm'	=> '$(INST_LIBDIR)/Ozeki/Libs/Rest/MessageMarkResult.pm',
            'lib/Ozeki/Libs/Rest/MessageReceiveResult.pm'	=> '$(INST_LIBDIR)/Ozeki/Libs/Rest/MessageReceiveResult.pm',
            'lib/Ozeki/Libs/Rest/MessageSendResult.pm'	=> '$(INST_LIBDIR)/Ozeki/Libs/Rest/MessageSendResult.pm',
            'lib/Ozeki/Libs/Rest/MessageSendResults.pm'	=> '$(INST_LIBDIR)/Ozeki/Libs/Rest/MessageSendResults.pm'
		}
		:
		{
			'lib/Ozeki/Libs/Rest/Configuration.pm'	=> '$(INST_LIBDIR)/Ozeki/Libs/Rest/Configuration.pm',
            'lib/Ozeki/Libs/Rest/Message.pm'	=> '$(INST_LIBDIR)/Ozeki/Libs/Rest/Message.pm',
            'lib/Ozeki/Libs/Rest/MessageApi.pm'	=> '$(INST_LIBDIR)/Ozeki/Libs/Rest/MessageApi.pm',
            'lib/Ozeki/Libs/Rest/Folder.pm'	=> '$(INST_LIBDIR)/Ozeki/Libs/Rest/Folder.pm',
            'lib/Ozeki/Libs/Rest/DeliveryStatus.pm'	=> '$(INST_LIBDIR)/Ozeki/Libs/Rest/DeliveryStatus.pm',
            'lib/Ozeki/Libs/Rest/MessageDeleteResult.pm'	=> '$(INST_LIBDIR)/Ozeki/Libs/Rest/MessageDeleteResult.pm',
            'lib/Ozeki/Libs/Rest/MessageMarkResult.pm'	=> '$(INST_LIBDIR)/Ozeki/Libs/Rest/MessageMarkResult.pm',
            'lib/Ozeki/Libs/Rest/MessageReceiveResult.pm'	=> '$(INST_LIBDIR)/Ozeki/Libs/Rest/MessageReceiveResult.pm',
            'lib/Ozeki/Libs/Rest/MessageSendResult.pm'	=> '$(INST_LIBDIR)/Ozeki/Libs/Rest/MessageSendResult.pm',
            'lib/Ozeki/Libs/Rest/MessageSendResults.pm'	=> '$(INST_LIBDIR)/Ozeki/Libs/Rest/MessageSendResults.pm'
		})
	);