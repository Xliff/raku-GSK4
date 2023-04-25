use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GLib::Value;
use GSK::RenderNode;

class GSK::Value is GLib::Value {

  method dup_render_node {
    gsk_value_dup_render_node(self.GValue);
  }

  method get_render_node (
    :quick(:$fast)  = False,
    :$raw           = False,
    :slow(:$proper) = $fast.not
  ) {
    returnProperNode(
      gsk_value_get_render_node(self.GValue),
      $raw,
      $proper
    );
  }

  method set_render_node (GskRenderNode() $node) {
    gsk_value_set_render_node(self.GValue, $node);
  }

  method take_render_node (GskRenderNode() $node) {
    gsk_value_take_render_node(self.GValue, $node);
  }

}
