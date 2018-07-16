/* File : liblogicalaccess_reader_sam.i */
%module(directors="1") liblogicalaccess_reader_sam

%{
#include <logicalaccess/plugins/readers/iso7816/commands/samiso7816commands.hpp>
#include <logicalaccess/plugins/readers/iso7816/commands/samav1iso7816commands.hpp>
#include <logicalaccess/plugins/cards/samav2/samav2commands.hpp>
#include <logicalaccess/plugins/readers/iso7816/commands/samav2iso7816commands.hpp>
%}

%shared_ptr(logicalaccess::SAMISO7816Commands<KeyEntryAV1Information, SETAV1>);
%shared_ptr(logicalaccess::SAMISO7816Commands<KeyEntryAV2Information, SETAV2>);
%shared_ptr(logicalaccess::SAMISO7816Commands<logicalaccess::KeyEntryAV1Information, logicalaccess::SETAV1>);
%shared_ptr(logicalaccess::SAMISO7816Commands<logicalaccess::KeyEntryAV2Information, logicalaccess::SETAV2>);

/* Include_section */

%include <logicalaccess/plugins/readers/iso7816/commands/samiso7816commands.hpp>
%include <logicalaccess/plugins/readers/iso7816/commands/samav1iso7816commands.hpp>
%include <logicalaccess/plugins/readers/iso7816/commands/samav2iso7816commands.hpp>

/* END_Include_section */