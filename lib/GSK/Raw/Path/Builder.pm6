use v6.c;

use NativeCall;

use Cairo;
use GLib::Raw::Definitions;
use Graphene::Raw::Definitions;
use Pango::Raw::Definitions;
use GSK::Raw::Definitions;
use GSK::Raw::Structs;

unit package GSK::Raw::Path::Builder:ver<4>;

### /usr/src/gtk4/gsk/gskpathbuilder.h

sub gsk_path_builder_add_cairo_path (
  GskPathBuilder      $self,
  Cairo::cairo_path_t $path
)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_add_circle (
  GskPathBuilder   $self,
  graphene_point_t $center,
  gfloat           $radius
)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_add_layout (
  GskPathBuilder $self,
  PangoLayout    $layout
)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_add_path (
  GskPathBuilder $self,
  GskPath        $path
)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_add_rect (
  GskPathBuilder  $self,
  graphene_rect_t $rect
)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_add_reverse_path (
  GskPathBuilder $self,
  GskPath        $path
)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_add_rounded_rect (
  GskPathBuilder $self,
  GskRoundedRect $rect
)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_add_segment (
  GskPathBuilder $self,
  GskPath        $path,
  GskPathPoint   $start,
  GskPathPoint   $end
)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_arc_to (
  GskPathBuilder $self,
  gfloat         $x1,
  gfloat         $y1,
  gfloat         $x2,
  gfloat         $y2
)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_close (GskPathBuilder $self)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_conic_to (
  GskPathBuilder $self,
  gfloat         $x1,
  gfloat         $y1,
  gfloat         $x2,
  gfloat         $y2,
  gfloat         $weight
)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_cubic_to (
  GskPathBuilder $self,
  gfloat         $x1,
  gfloat         $y1,
  gfloat         $x2,
  gfloat         $y2,
  gfloat         $x3,
  gfloat         $y3
)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_free_to_path (GskPathBuilder $self)
  returns GskPath
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_get_current_point (GskPathBuilder $self)
  returns graphene_point_t
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_html_arc_to (
  GskPathBuilder $self,
  gfloat         $x1,
  gfloat         $y1,
  gfloat         $x2,
  gfloat         $y2,
  gfloat         $radius
)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_line_to (
  GskPathBuilder $self,
  gfloat         $x,
  gfloat         $y
)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_move_to (
  GskPathBuilder $self,
  gfloat         $x,
  gfloat         $y
)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_new
  returns GskPathBuilder
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_quad_to (
  GskPathBuilder $self,
  gfloat         $x1,
  gfloat         $y1,
  gfloat         $x2,
  gfloat         $y2
)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_ref (GskPathBuilder $self)
  returns GskPathBuilder
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_rel_arc_to (
  GskPathBuilder $self,
  gfloat         $x1,
  gfloat         $y1,
  gfloat         $x2,
  gfloat         $y2
)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_rel_conic_to (
  GskPathBuilder $self,
  gfloat         $x1,
  gfloat         $y1,
  gfloat         $x2,
  gfloat         $y2,
  gfloat         $weight
)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_rel_cubic_to (
  GskPathBuilder $self,
  gfloat         $x1,
  gfloat         $y1,
  gfloat         $x2,
  gfloat         $y2,
  gfloat         $x3,
  gfloat         $y3
)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_rel_html_arc_to (
  GskPathBuilder $self,
  gfloat         $x1,
  gfloat         $y1,
  gfloat         $x2,
  gfloat         $y2,
  gfloat         $radius
)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_rel_line_to (
  GskPathBuilder $self,
  gfloat         $x,
  gfloat         $y
)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_rel_move_to (
  GskPathBuilder $self,
  gfloat         $x,
  gfloat         $y
)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_rel_quad_to (
  GskPathBuilder $self,
  gfloat         $x1,
  gfloat         $y1,
  gfloat         $x2,
  gfloat         $y2
)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_rel_svg_arc_to (
  GskPathBuilder $self,
  gfloat         $rx,
  gfloat         $ry,
  gfloat         $x_axis_rotation,
  gboolean       $large_arc,
  gboolean       $positive_sweep,
  gfloat         $x,
  gfloat         $y
)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_svg_arc_to (
  GskPathBuilder $self,
  gfloat         $rx,
  gfloat         $ry,
  gfloat         $x_axis_rotation,
  gboolean       $large_arc,
  gboolean       $positive_sweep,
  gfloat         $x,
  gfloat         $y
)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_to_path (GskPathBuilder $self)
  returns GskPath
  is      native(gsk)
  is      export
{ * }

sub gsk_path_builder_unref (GskPathBuilder $self)
  is      native(gsk)
  is      export
{ * }
