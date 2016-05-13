/* File : liblogicalaccess_card.i */
%module(directors="1") liblogicalaccess_card

%include "liblogicalaccess.i"

%import "liblogicalaccess_data.i"

%typemap(csimports) SWIGTYPE
%{
using LibLogicalAccess;
%}

%shared_ptr(logicalaccess::Chip);
%shared_ptr(logicalaccess::Commands);
%shared_ptr(logicalaccess::Key);
%shared_ptr(logicalaccess::KeyDiversification);
%shared_ptr(logicalaccess::KeyStorage);
%shared_ptr(logicalaccess::LocationNode);
%shared_ptr(logicalaccess::Profile);
%shared_ptr(logicalaccess::Location);
%shared_ptr(logicalaccess::AccessInfo);
%shared_ptr(logicalaccess::CardService);
%shared_ptr(logicalaccess::CardsFormatComposite);

typedef std::shared_ptr<logicalaccess::Chip> ChipPtr;
typedef std::shared_ptr<logicalaccess::Key> KeyPtr;

%ignore logicalaccess::Commands::getChip;

%{
#include <logicalaccess/cards/chip.hpp>
#include <logicalaccess/cards/accessinfo.hpp>
#include <logicalaccess/cards/locationnode.hpp>
#include <logicalaccess/services/cardservice.hpp>
#include <logicalaccess/services/accesscontrol/cardsformatcomposite.hpp>
#include <logicalaccess/cards/commands.hpp>

using namespace logicalaccess;

%}

%ignore logicalaccess::Commands;

/* original header files */
%include <logicalaccess/cards/location.hpp>
%include <logicalaccess/cards/accessinfo.hpp>
%include <logicalaccess/cards/locationnode.hpp>
%include <logicalaccess/cards/profile.hpp>
%include <logicalaccess/cards/commands.hpp>
%include <logicalaccess/services/cardservice.hpp>
%include <logicalaccess/cards/chip.hpp>
%include <logicalaccess/cards/keydiversification.hpp>
%include <logicalaccess/cards/keystorage.hpp>
%include <logicalaccess/key.hpp>
%include <logicalaccess/services/accesscontrol/cardsformatcomposite.hpp>

%template(ChipCollection) std::vector<std::shared_ptr<logicalaccess::Chip> >;