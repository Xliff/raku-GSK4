use v6.c;

use Method::Also;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

our subset GskTextureNodeAncestry is export of Mu
  where GskTextureNode | GskRenderNode;

class GSK::Node::Texture:ver<4> is GSK::RenderNode:ver<4> {
  also does GLib::Roles::Implementor;

  has GskTextureNode $!gsk-tn is implementor;

  submethod BUILD ( :$gsk-texture-node ) {
    self.setGskTextureNode($gsk-texture-node) if $gsk-texture-node
  }

  method setGskTextureNode (GskTextureNodeAncestry $_) {
    my $to-parent;

    $!gsk-tn = do {
      when GskTextureNode {
        $to-parent = cast(GskRenderNode, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GskTextureNode, $_);
      }
    }
    self.setGskRenderNode($to-parent);
  }

  method GSK::Raw::Definitions::GskTextureNode
    is also<GskTextureNode>
  { $!gsk-tn }

  multi method new (GskTextureNodeAncestry $gsk-texture-node, :$ref = True) {
    return unless $gsk-texture-node;

    my $o = self.bless( :$gsk-texture-node );
    $o.ref if $ref;
    $o;
  }
  multi method new (GdkTexture() $texture, graphene_rect_t() $bounds) {
    my $gsk-texture-node = gsk_texture_node_new($texture, $bounds);

    $gsk-texture-node ?? self.bless( :$gsk-texture-node ) !! Nil;
  }

  method get_texture ( :$raw = False )
    is also<
      get-texture
      texture
    >
  {
    propReturnObject(
      gsk_texture_node_get_texture($!gsk-tn),
      $raw,
      |GDK::Texture.getTypePair
    )
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_texture_node_get_type, $n, $t );
  }

}

INIT {
  my \O = GSK::Node::Texture;
  %render-node-types<Texture> = {
    object => O,
    type   => O.get_type
  }
}
