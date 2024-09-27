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
  HAS GdkRGBA $!color;

  submethod BUILD ( :$!offset, :$color ) {
    self.color = $color;
  }

  method color is rw {
    Proxy.new:
      FETCH => -> $               { $!color },
      STORE => -> $, GdkRGBA() $c {
        ( .red, .green, .blue, .alpha ) =
          ( $c.red, $c.green, $c.blue, $c.alpha )
        given $!color;
      }
  }

  method gist {
    qq:to/GIST/;
      GskColorStop.new( offset => { $!offset }, color => { $!color.gist } )";
      GIST
  }

  multi method new ( :$offset, :$color ) {
    samewith($offset, $color);
  }
  multi method new (Num() $o, $color) {
    my gfloat $offset = $o;

    self.bless( :$offset, :$color )
  }
}

class GskParseLocation is repr<CStruct> does GLib::Roles::Pointers is export {
  has gsize $.bytes;
  has gsize $.chars;
  has gsize $.lines;
  has gsize $.line_byte;
  has gsize $.line_char;

  method line-byte { $!line_byte }
  method line-char { $!line_char }
}

class GskShadow       is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS GdkRGBA $.color;
  has gfloat  $.dx     is rw;
  has gfloat  $.dy     is rw;
  has gfloat  $.radius is rw;
}

class GskPPContour     is repr<CStruct> does GLib::Roles::Pointers is export {
  has gsize  $.contour;
  has gsize  $.idx;
  has gfloat $.t;
}

class GskPathPoint     is repr<CUnion> does GLib::Roles::Pointers is export {
  HAS GskPPContour    $.contour;
  HAS gpointer        @.padding[8] is CArray;
  HAS graphene_vec4_t $.alignment;
};
