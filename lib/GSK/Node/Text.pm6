use v6.c;

use Method::Also;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use Pango::Font;
use Pango::GlyphString;
use Graphene::Point;
use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

our subset GskTextNodeAncestry is export of Mu
  where GskTextNode | GskRenderNode;

class GSK::Node::Text:ver<4> is GSK::RenderNode:ver<4> {
  also does GLib::Roles::Implementor;

  has GskTextNode $!gsk-tn is implementor;

  submethod BUILD ( :$gsk-transform-node ) {
    self.setGskTextNode($gsk-transform-node) if $gsk-transform-node
  }

  method setGskTextNode (GskTextNodeAncestry $_) {
    my $to-parent;

    $!gsk-tn = do {
      when GskTextNode {
        $to-parent = cast(GskRenderNode, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GskTextNode, $_);
      }
    }
    self.setGskRenderNode($to-parent);
  }

  method GSK::Raw::Definitions::GskTextNode
    is also<GskTextNode>
  { $!gsk-tn }

  multi method new (GskTextNodeAncestry $gsk-transform-node, :$ref = True) {
    return unless $gsk-transform-node;

    my $o = self.bless( :$gsk-transform-node );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    PangoFont()        $font,
    PangoGlyphString() $glyphs,
    GdkRGBA()          $color,
    graphene_point_t() $offset
  ) {
    my $gsk-text-node = gsk_text_node_new($font, $glyphs, $color, $offset);

    $gsk-text-node ?? self.bless( :$gsk-text-node ) !! Nil;
  }

  method get_color ( :$raw = False )
    is also<
      get-color
      color
    >
  {
    propReturnObject(
      gsk_text_node_get_color($!gsk-tn),
      $raw,
      |GDK::RGBA.getTypePair
    );
  }

  method get_font ( :$raw = False )
    is also<
      get-font
      font
    >
  {
    propReturnObject(
      gsk_text_node_get_font($!gsk-tn),
      $raw,
      |Pango::Font.getTypePair
    );
  }


  proto method get_glyphs (|)
  { * }

  multi method get_glyphs ( :$raw = False ) {
    samewith($, :$raw)
  }
  multi method get_glyphs ($n_glyphs is rw, :$raw = False, :$buffer = False)
    is also<get-glyphs>
  {
    my guint $n = 0;

    my $ga = gsk_text_node_get_glyphs($!gsk-tn, $n);
    $n_glyphs = $n;
    $ga = GLib::Roles::TypedBuffer[PangoGlyphInfo].new($ga);
    return $ga if $buffer;
    $raw ?? $ga.Array
         !! $ga.Array.map({ Pango::GlyphInfo.new( $_ ) });
  }

  method get_num_glyphs
    is also<
      get-num-glyphs
      num-glyphs
      elems
    >
  {
    gsk_text_node_get_num_glyphs($!gsk-tn);
  }

  method get_offset ( :$raw = False )
    is also<
      get-offset
      offset
    >
  {
    propReturnObject(
      gsk_text_node_get_offset($!gsk-tn),
      $raw,
      |Graphene::Point.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_text_node_get_type, $n, $t );
  }

  method has_color_glyphs is also<has-color-glyphs> {
    so gsk_text_node_has_color_glyphs($!gsk-tn);
  }

}

INIT {
  my \O = GSK::Node::Text;
  %render-node-types<Text> = {
    object => O,
    type   => O.get_type
  }
}
