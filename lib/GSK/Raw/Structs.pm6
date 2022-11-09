use v6.c;

use GLib::Raw::Definitions;
use Graphene::Raw::Definitions;
use GSK::Raw::Definitions;

use GLib::Roles::Pointers;

unit package GSK::Raw::Structs:ver<4>;

class GskRoundedRect is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS graphene_rect_t $.bounds;
  HAS graphene_size_t $.corner0;
  HAS graphene_size_t $.corner1;
  HAS graphene_size_t $.corner2;
  HAS graphene_size_t $.corner3;
}
