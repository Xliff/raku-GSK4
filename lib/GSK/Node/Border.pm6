use v6.c;

use NativeCall;
use Method::Also;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GDK::RGBA:ver<4>;
use GSK::RenderNode:ver<4>;
use GSK::RoundedRect:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::TypedBuffer;

our subset GskBorderNodeAncestry is export of Mu
  where GskBorderNode | GskRenderNode;

class GSK::Node::Border:ver<4> is GSK::RenderNode:ver<4> {
  also does GLib::Roles::Implementor;

  has GskBorderNode $!gsk-bn is implementor;

  submethod BUILD ( :$gsk-border-node ) {
    self.setGskBorderNode($gsk-border-node) if $gsk-border-node
  }

  method setGskBorderNode (GskBorderNodeAncestry $_) {
    my $to-parent;

    $!gsk-bn = do {
      when GskBorderNode {
        $to-parent = cast(GskRenderNode, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GskBorderNode, $_);
      }
    }
    self.setGskRenderNode($to-parent);
  }

  method GSK::Raw::Definitions::GskBorderNode
    is also<GskBorderNode>
  { $!gsk-bn }

  multi method new (GskBorderNodeAncestry $gsk-border-node, :$ref = True) {
    return unless $gsk-border-node;

    my $o = self.bless( :$gsk-border-node );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    GskRoundedRect() $outline,
    Num()            $border_width,
    GdkRGBA()        $border_color
  ) {
    samewith(
      $outline,
      $border_width xx 4,
      $border_color xx 4
    );
  }
  multi method new (
    GskRoundedRect()  $outline,
                     :$top-width    = 0,
                     :$right-width  = 0,
                     :$bottom-width = 0,
                     :$left-width   = 0,
                     :$top-color    = GdkRGBA.new,
                     :$right-color  = GdkRGBA.new,
                     :$left-color   = GdkRGBA.new,
                     :$bottom-color = GdkRGBA.new
  ) {
    samewith(
      $outline,
      ($top-width, $right-width, $bottom-width, $left-width),
      ($top-color, $right-color, $bottom-color, $left-color)
    );
  }
  multi method new (GskRoundedRect() $outline, @widths, @colors) {
    samewith(
      $outline,
      ArrayToCArray(gfloat, @widths),
      GLib::Roles::TypedBuffer.new(@colors).p
    );
  }
  multi method new (
    GskRoundedRect() $outline,
    CArray[gfloat]   $border_widths,
    Pointer          $border_colors
  ) {
    my $gsk-border-node = gsk_border_node_new(
      $outline,
      $border_widths,
      $border_colors
    );

    $gsk-border-node ?? self.bless( :$gsk-border-node ) !! Nil;
  }

  method get_colors ( :$buffer = False, :$raw = False )
    is also<
      get-colors
      colors
    >
  {
    bufferReturnTypedArray(
       gsk_border_node_get_colors($!gsk-bn),
      |GDK::RGBA.getTypePair,
       size    => 4,
      :$buffer,
      :$raw
    );
  }

  method get_outline ( :$raw = False )
    is also<
      get-outline
      outline
    >
  {
    propReturnObject(
      gsk_border_node_get_outline($!gsk-bn),
      $raw,
      |GSK::RoundedRect.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_border_node_get_type, $n, $t );
  }

  method get_widths (:$carray = False )
    is also<
      get-widths
      widths
    >
  {
    my $wa = gsk_border_node_get_widths($!gsk-bn);
    return $wa if $carray;
    CArrayToArray($wa, 4 );
  }

}
