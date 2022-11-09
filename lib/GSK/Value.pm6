use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

class GSK::Value is GLib::Value {

  method getNodePair {
    # cw: How do to this in the LEAST expensive way possible?
    die 'getNodePair NYI';
  }

  method dup_render_node {
    gsk_value_dup_render_node($value);
  }

  method get_render_node ( :$raw = False, :$node = True ) {
    my $node-type = $node ?? GSK::RenderNode.getType
                          !! self.getNodePair;

    propReturnObject(
      gsk_value_get_render_node($value),
      $raw,
      |$node-type.getTypePair
    );
  }

  method set_render_node (GskRenderNode() $node) {
    gsk_value_set_render_node($value, $node);
  }

  method take_render_node (GskRenderNode() $node) {
    gsk_value_take_render_node($value, $node);
  }

}
