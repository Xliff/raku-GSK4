use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Graphene::Raw::Definitions;
use GDK::Raw::Structs:ver<4>;
use GSK::Raw::Definitions;

use GLib::Roles::Pointers;

unit package GSK::Raw::Structs:ver<4>;

class GskRoundedRect   is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS graphene_rect_t $.bounds;
  HAS graphene_size_t $.corner0;
  HAS graphene_size_t $.corner1;
  HAS graphene_size_t $.corner2;
  HAS graphene_size_t $.corner3;
}

class GskColorStop     is repr<CStruct> does GLib::Roles::Pointers is export {
  has gfloat  $.offset is rw;
  HAS GdkRGBA $.color;
}

class GskParseLocation is repr<CStruct> does GLib::Roles::Pointers is export {
  has gsize $.bytes;
  has gsize $.chars;
  has gsize $.lines;
  has gsize $.line_byte;
  has gsize $.line_char;
}

class GskShadow       is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS GdkRGBA $.color;
  has gfloat  $.dx     is rw;
  has gfloat  $.dy     is rw;
  has gfloat  $.radius is rw;
}
