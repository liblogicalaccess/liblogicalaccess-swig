/* File : liblogicalaccess_readerservice.i */

%import "liblogicalaccess_data.i"

%{
	#include <logicalaccess/services/reader_service.hpp>
	#include <logicalaccess/services/accesscontrol/readerformatcomposite.hpp>
	#include <logicalaccess/services/licensechecker/license_checker_service.hpp>
	
	using namespace logicalaccess;
%}

//%template(ReaderServiceEnableShared) std::enable_shared_from_this<logicalaccess::ReaderService>;

%include <logicalaccess/services/reader_service.hpp>
%include <logicalaccess/services/accesscontrol/readerformatcomposite.hpp>
%include <logicalaccess/services/licensechecker/license_checker_service.hpp>
