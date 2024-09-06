use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Graphene::Raw::Definitions;
use GSK::Raw::Definitions;
use GSK::Raw::Enums;
use GSK::Raw::Structs;

unit package GSK::Raw::Path::Point:ver<4>;

### /usr/src/gtk4/gsk/gskpathpoint.h

sub gsk_path_point_compare (
  GskPathPoint $point1,
  GskPathPoint $point2
)
  returns gint
  is      native(gsk)
  is      export
{ * }

sub gsk_path_point_copy (GskPathPoint $point)
  returns GskPathPoint
  is      native(gsk)
  is      export
{ * }

sub gsk_path_point_equal (
  GskPathPoint $point1,
  GskPathPoint $point2
)
  returns uint32
  is      native(gsk)
  is      export
{ * }

sub gsk_path_point_free (GskPathPoint $point)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_point_get_curvature (
  GskPathPoint     $point,
  GskPath          $path,
  GskPathDirection $direction,
  graphene_point_t $center
)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_path_point_get_distance (
  GskPathPoint   $point,
  GskPathMeasure $measure
)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_path_point_get_position (
  GskPathPoint     $point,
  GskPath          $path,
  graphene_point_t $position
)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_point_get_rotation (
  GskPathPoint     $point,
  GskPath          $path,
  GskPathDirection $direction
)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_path_point_get_tangent (
  GskPathPoint     $point,
  GskPath          $path,
  GskPathDirection $direction,
  graphene_vec2_t  $tangent
)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_point_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }
