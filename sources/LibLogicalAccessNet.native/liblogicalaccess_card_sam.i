/* File : liblogicalaccess_card_sam.i */
%module(directors="1") liblogicalaccess_card_sam

%{
#include <logicalaccess/plugins/cards/desfire/desfirekey.hpp>
#include <logicalaccess/plugins/cards/desfire/desfirecrypto.hpp>
#include <logicalaccess/plugins/cards/samav/samcrypto.hpp>
#include <logicalaccess/plugins/cards/samav/sambasickeyentry.hpp>
#include <logicalaccess/plugins/cards/samav/samkeyentry.hpp>
#include <logicalaccess/plugins/cards/samav/samkucentry.hpp>
#include <logicalaccess/plugins/cards/samav/samcommands.hpp>
#include <logicalaccess/plugins/cards/samav/samav2commands.hpp>
#include <logicalaccess/plugins/cards/samav/samav3commands.hpp>
%}

%shared_ptr(logicalaccess::SAMAV3Commands);
%shared_ptr(logicalaccess::SAMAV2Commands<KeyEntryAV2Information, SETAV2>);
%shared_ptr(logicalaccess::SAMKeyEntry<KeyEntryAV1Information, SETAV1>);
%shared_ptr(logicalaccess::SAMKeyEntry<KeyEntryAV2Information, SETAV2>);
%shared_ptr(logicalaccess::SAMCommands<KeyEntryAV1Information, SETAV1>);
%shared_ptr(logicalaccess::SAMCommands<KeyEntryAV2Information, SETAV2>);

%shared_ptr(logicalaccess::SAMAV2Commands<logicalaccess::KeyEntryAV2Information, logicalaccess::SETAV2>);
%shared_ptr(logicalaccess::SAMKeyEntry<logicalaccess::KeyEntryAV1Information, logicalaccess::SETAV1>);
%shared_ptr(logicalaccess::SAMKeyEntry<logicalaccess::KeyEntryAV2Information, logicalaccess::SETAV2>);
%shared_ptr(logicalaccess::SAMCommands<logicalaccess::KeyEntryAV1Information, logicalaccess::SETAV1>);
%shared_ptr(logicalaccess::SAMCommands<logicalaccess::KeyEntryAV2Information, logicalaccess::SETAV2>);

/* Include_section */

%include <logicalaccess/plugins/cards/desfire/desfirekey.hpp>
%include <logicalaccess/plugins/cards/desfire/desfirecrypto.hpp>
%include <logicalaccess/plugins/cards/samav/samcrypto.hpp>
%include <logicalaccess/plugins/cards/samav/sambasickeyentry.hpp>
%include <logicalaccess/plugins/cards/samav/samkeyentry.hpp>
%include <logicalaccess/plugins/cards/samav/samkucentry.hpp>
%include <logicalaccess/plugins/cards/samav/samcommands.hpp>
%include <logicalaccess/plugins/cards/samav/samav2commands.hpp>
%include <logicalaccess/plugins/cards/samav/samav3commands.hpp>

/* END_Include_section */

%template(AV1SAMKeyEntry) logicalaccess::SAMKeyEntry<logicalaccess::KeyEntryAV1Information, logicalaccess::SETAV1>;
%template(AV2SAMKeyEntry) logicalaccess::SAMKeyEntry<logicalaccess::KeyEntryAV2Information, logicalaccess::SETAV2>;
%template(AV2SAMAV2Commands) logicalaccess::SAMAV2Commands<logicalaccess::KeyEntryAV2Information, logicalaccess::SETAV2>;