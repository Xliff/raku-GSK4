use v6.c;

use Method::Also;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

our subset GskCrossFadeNodeAncestry is export of Mu
  where GskCrossFadeNode | GskRenderNode;

class GSK::Node::CrossFade:ver<4> is GSK::RenderNode:ver<4> {
  also does GLib::Roles::Implementor;

  has GskCrossFadeNode $!gsk-cn is implementor;

  submethod BUILD ( :$gsk-crossfade-node ) {
    self.setGskCrossFadeNode($gsk-crossfade-node) if $gsk-crossfade-node
  }

  method setGskCrossFadeNode (GskCrossFadeNodeAncestry $_) {
    my $to-parent;

    $!gsk-cn = do {
      when GskCrossFadeNode {
        $to-parent = cast(GskRenderNode, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GskCrossFadeNode, $_);
      }
    }
    self.setGskRenderNode($to-parent);
  }

  method GSK::Raw::Definitions::GskCrossFadeNode
    is also<GskCrossFadeNode>
  { $!gsk-cn }

  multi method new (
    GskCrossFadeNodeAncestry  $gsk-crossfade-node,
                             :$ref                 = True
  ) {
    return unless $gsk-crossfade-node;

    my $o = self.bless( :$gsk-crossfade-node );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    GskRenderNode() $start,
    GskRenderNode() $end,
    Num()           $progress
  ) {
    my gfloat $p = $progress;

    my $gsk-cross-fade-node = gsk_cross_fade_node_new($start, $end, $p);

    $gsk-cross-fade-node ?? self.bless( :$gsk-cross-fade-node ) !! Nil;
  }

  method get_end_child (
    :quick(:$fast)  = False,
    :$raw           = False,
    :slow(:$proper) = $fast.not
  )
    is also<
      get-end-child
      end_child
      end-child
    >
  {
    returnProperNode(
      gsk_cross_fade_node_get_end_child($!gsk-cn),
      $raw,
      $proper
    );
  }

  method get_progress
    is also<
      get-progress
      progress
    >
  {
    gsk_cross_fade_node_get_progress($!gsk-cn);
  }

  method get_start_child (
    :quick(:$fast)  = False,
    :$raw           = False,
    :slow(:$proper) = $fast.not
  )
    is also<
      get-start-child
      start_child
      start-child
    >
  {
    returnProperNode(
      gsk_cross_fade_node_get_start_child($!gsk-cn),
      $raw,
      $proper
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_cross_fade_node_get_type, $n, $t );
  }

}

INIT {
  my \O = GSK::Node::CrossFade;
  %render-node-types<CrossFade> = {
    object    => O,
    node-type => GSK_CROSS_FADE_NODE,
    type      => O.get_type
  }
}
