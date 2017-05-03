/* File : liblogicalaccess_readerservice.i */

%import "liblogicalaccess_data.i"

%shared_ptr(logicalaccess::ReaderService);
//%feature("director") ReaderService;
%shared_ptr(logicalaccess::ReaderFormatComposite);
%shared_ptr(logicalaccess::LicenseCheckerService);
//%feature("director") LicenseCheckerService;

%{
	#include <logicalaccess/services/reader_service.hpp>
	#include <logicalaccess/services/accesscontrol/readerformatcomposite.hpp>
	#include <logicalaccess/services/licensechecker/license_checker_service.hpp>
	#include <logicalaccess/services/nfc/p2p/llcpinitiator.hpp>
%}

%shared_ptr(logicalaccess::LLCPInitiator);

%include <logicalaccess/services/reader_service.hpp>
%include <logicalaccess/services/accesscontrol/readerformatcomposite.hpp>
%include <logicalaccess/services/licensechecker/license_checker_service.hpp>
%include <logicalaccess/services/nfc/p2p/llcpinitiator.hpp>