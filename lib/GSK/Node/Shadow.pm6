use v6.c;

use NativeCall;
use Method::Also;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

our subset GskShadowNodeAncestry is export of Mu
  where GskShadowNode | GskRenderNode;

class GSK::Node::Shadow:ver<4> is GSK::RenderNode:ver<4> {
  also does GLib::Roles::Implementor;
  also does Positional;

  has GskShadowNode $!gsk-sn is implementor;

  submethod BUILD ( :$gsk-shadow-node ) {
    self.setGskShadowNode($gsk-shadow-node) if $gsk-shadow-node
  }

  method setGskShadowNode (GskShadowNodeAncestry $_) {
    my $to-parent;

    $!gsk-sn = do {
      when GskShadowNode {
        $to-parent = cast(GskRenderNode, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GskShadowNode, $_);
      }
    }
    self.setGskRenderNode($to-parent);
  }

  method GSK::Raw::Definitions::GskShadowNode
    is also<GskShadowNode>
  { $!gsk-sn }

  multi method new (GskShadowNodeAncestry $gsk-shadow-node, :$ref = True) {
    return unless $gsk-shadow-node;

    my $o = self.bless( :$gsk-shadow-node );
    $o.ref if $ref;
    $o;
  }
  multi method new (GskRenderNode() $child, @shadows) {
    samewith(
      $child,
      ArrayToCArray(GskShadow, @shadows),
      @shadows.elems
    );
  }
  multi method new (
    GskRenderNode()   $child,
    CArray[GskShadow] $shadows,
    Int()             $n_shadows
  ) {
    my gsize $n = $n_shadows;

    my $gsk-shadow-node = gsk_shadow_node_new($child, $shadows, $n);

    $gsk-shadow-node ?? self.bless( :$gsk-shadow-node ) !! Nil;
  }

  method get_child ( :$raw = False )
    is also<
      get-child
      child
    >
  {
    propReturnObject(
      gsk_shadow_node_get_child($!gsk-sn),
      $raw,
      |GSK::RenderNode.getTypePair
    );
  }

  method get_n_shadows
    is also<
      get-n-shadows
      n_shadows
      n-shadows
      elems
    >
  {
    gsk_shadow_node_get_n_shadows($!gsk-sn);
  }

  method get_shadow (Int() $i) is also<get-shadow> {
    my gsize $ii = $i;

    gsk_shadow_node_get_shadow($!gsk-sn, $ii);
  }
  method AT-POS (\k) is also<AT_POS> {
    self.get_shadow(k);
  }
  method Array {
    my @s;
    @s.push: self[$_] for ^self.elems;
    @s;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_shadow_node_get_type, $n, $t );
  }

}

INIT {
  my \O = GSK::Node::Shadow;
  %render-node-types<Shadow> = {
    object => O,
    type   => O.get_type
  }
}
