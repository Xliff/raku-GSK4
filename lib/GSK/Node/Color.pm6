use v6.c;

use Method::Also;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

our subset GskColorNodeAncestry is export of Mu
  where GskColorNode | GskRenderNode;

class GSK::Node::Color:ver<4> is GSK::RenderNode:ver<4> {
  also does GLib::Roles::Implementor;

  has GskColorNode $!gsk-cn is implementor;

  submethod BUILD ( :$gsk-color-node ) {
    self.setGskColorNode($gsk-color-node) if $gsk-color-node
  }

  method setGskColorNode (GskColorNodeAncestry $_) {
    my $to-parent;

    $!gsk-cn = do {
      when GskColorNode {
        $to-parent = cast(GskRenderNode, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GskColorNode, $_);
      }
    }
    self.setGskRenderNode($to-parent);
  }

  method GSK::Raw::Definitions::GskColorNode
    is also<GskColorNode>
  { $!gsk-cn }

  multi method new (GskColorNodeAncestry $gsk-color-node, :$ref = True) {
    return unless $gsk-color-node;

    my $o = self.bless( :$gsk-color-node );
    $o.ref if $ref;
    $o;
  }
  multi method new (GdkRGBA() $rgba, graphene_rect_t() $bounds) {
    my $gsk-color-node = gsk_color_node_new($rgba, $bounds);

    $gsk-color-node ?? self.bless( :$gsk-color-node ) !! Nil
  }

  method get_color ( :$raw = False )
    is also<
      get-color
      color
    >
  {
    propReturnObject(
      gsk_color_node_get_color($!gsk-cn),
      $raw,
      |GDK::RGBA.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_color_node_get_type, $n, $t );
  }

}

INIT {
  my \O = GSK::Node::Color;
  %render-node-types<Color> = {
    object    => O,
    node-type => GSK_COLOR_NODE,
    pair      => O.getTypePair
  }
}
