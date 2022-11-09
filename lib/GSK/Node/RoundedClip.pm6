use v6.c;

use Method::Also;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

our subset GskRoundedClipNodeAncestry is export of Mu
  where GskRoundedClipNode | GskRenderNode;

class GSK::Node::RoundedClip:ver<4> is GSK::RenderNode:ver<4> {
  also does GLib::Roles::Implementor;

  has GskRoundedClipNode $!gsk-rn is implementor;

  submethod BUILD ( :$gsk-rclip-node ) {
    self.setGskRoundedClipNode($gsk-rclip-node) if $gsk-rclip-node
  }

  method setGskRoundedClipNode (GskRoundedClipNodeAncestry $_) {
    my $to-parent;

    $!gsk-rn = do {
      when GskRoundedClipNode {
        $to-parent = cast(GskRenderNode, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GskRoundedClipNode, $_);
      }
    }
    self.setGskRenderNode($to-parent);
  }

  method GSK::Raw::Definitions::GskRoundedClipNode
    is also<GskRoundedClipNode>
  { $!gsk-rn }

  multi method new (
    GskRoundedClipNodeAncestry  $gsk-rclip-node,
                               :$ref             = True
  ) {
    return unless $gsk-rclip-node;

    my $o = self.bless( :$gsk-rclip-node );
    $o.ref if $ref;
    $o;
  }
  multi method new (GskRenderNode() $child, GskRoundedRect() $clip) {
    my $gsk-rclip-node = gsk_rounded_clip_node_new($child, $clip);

    $gsk-rclip-node ?? self.bless( :$gsk-rclip-node ) !! Nil;
  }

  method get_child ( :$raw = False )
    is also<
      get-child
      child
    >
  {
    propReturnObject(
      gsk_rounded_clip_node_get_child($!gsk-rn),
      $raw,
      |GSK::RenderNode.getTypePair
    );
  }

  method get_clip ( :$raw = False )
    is also<
      get-clip
      clip
    >
  {
    propReturnObject(
      gsk_rounded_clip_node_get_clip($!gsk-rn),
      $raw,
      |GSK::RoundedRect.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_rounded_clip_node_get_type, $n, $t );
  }

}
