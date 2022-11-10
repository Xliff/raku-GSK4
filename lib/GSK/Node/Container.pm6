use v6.c;

use NativeCall;
use Method::Also;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

our subset GskContainerNodeAncestry is export of Mu
  where GskContainerNode | GskRenderNode;

class GSK::Node::Container:ver<4> is GSK::RenderNode:ver<4> {
  also does GLib::Roles::Implementor;
  also does Positional;

  has GskContainerNode $!gsk-cn is implementor;

  submethod BUILD ( :$gsk-container-node ) {
    self.setGskContainerNode($gsk-container-node) if $gsk-container-node
  }

  method setGskContainerNode (GskContainerNodeAncestry $_) {
    my $to-parent;

    $!gsk-cn = do {
      when GskContainerNode {
        $to-parent = cast(GskRenderNode, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GskContainerNode, $_);
      }
    }
    self.setGskRenderNode($to-parent);
  }

  method GSK::Raw::Definitions::GskContainerNode
    is also<GskContainerNode>
  { $!gsk-cn }

  multi method new (
    GskContainerNodeAncestry  $gsk-container-node,
                             :$ref                 = True
  ) {
    return unless $gsk-container-node;

    my $o = self.bless( :$gsk-container-node );
    $o.ref if $ref;
    $o;
  }
  multi method new (@children) {
    samewith(
      ArrayToCArray(GskRenderNode, @children),
      @children.elems
    );
  }
  multi method new (
    CArray[GskRenderNode] $children,
    Int()                 $n_children
  ) {
    my guint $n = $n_children;

    gsk_container_node_new($children, $n);
  }

  method get_child (Int() $idx, :$raw = False)
    is also<
      get-child
      child
    >
  {
    my guint $i = $idx;

    propReturnObject(
      gsk_container_node_get_child($!gsk-cn, $i),
      $raw,
      |GSK::RenderNode.getTypePair
    );
  }
  method AT-POS (\k) {
    self.get_child(k);
  }
  method Array {
    my @a;
    @a.push: self[$_] for ^self.elems;
    @a;
  }

  method get_n_children
    is also<
      get-n-children
      n_children
      n-children
      elems
    >
  {
    gsk_container_node_get_n_children($!gsk-cn);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_container_node_get_type, $n, $t );
  }

}
