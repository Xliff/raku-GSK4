use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GSK::Raw::Definitions;
use GSK::Raw::Structs;

unit package GSK::Raw::Transform:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gsk/gsktransform.h

sub gsk_transform_equal (GskTransform $first, GskTransform $second)
  returns uint32
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_get_category (GskTransform $self)
  returns GskTransformCategory
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_invert (GskTransform $self)
  returns GskTransform
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_matrix (GskTransform $next, graphene_matrix_t $matrix)
  returns GskTransform
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_new
  returns GskTransform
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_parse (
  Str                           $string,
  CArray[Pointer[GskTransform]] $out_transform
)
  returns uint32
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_perspective (GskTransform $next, gfloat $depth)
  returns GskTransform
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_print (GskTransform $self, GString $string)
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_ref (GskTransform $self)
  returns GskTransform
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_rotate (GskTransform $next, gfloat $angle)
  returns GskTransform
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_rotate_3d (
  GskTransform    $next,
  gfloat          $angle,
  graphene_vec3_t $axis
)
  returns GskTransform
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_scale (
  GskTransform $next,
  gfloat       $factor_x,
  gfloat       $factor_y
)
  returns GskTransform
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_scale_3d (
  GskTransform $next,
  gfloat       $factor_x,
  gfloat       $factor_y,
  gfloat       $factor_z
)
  returns GskTransform
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_skew (
  GskTransform $next,
  gfloat       $skew_x,
  gfloat       $skew_y
)
  returns GskTransform
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_to_2d (
  GskTransform $self,
  gfloat       $out_xx is rw,
  gfloat       $out_yx is rw,
  gfloat       $out_xy is rw,
  gfloat       $out_yy is rw,
  gfloat       $out_dx is rw,
  gfloat       $out_dy is rw
)
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_to_2d_components (
  GskTransform $self,
  gfloat       $out_skew_x   is rw,
  gfloat       $out_skew_y   is rw,
  gfloat       $out_scale_x  is rw,
  gfloat       $out_scale_y  is rw,
  gfloat       $out_angle    is rw,
  gfloat       $out_dx       is rw,
  gfloat       $out_dy       is rw
)
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_to_affine (
  GskTransform $self,
  gfloat       $out_scale_x is rw,
  gfloat       $out_scale_y is rw,
  gfloat       $out_dx      is rw,
  gfloat       $out_dy      is rw
)
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_to_matrix (
  GskTransform      $self,
  graphene_matrix_t $out_matrix
)
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_to_string (GskTransform $self)
  returns Str
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_to_translate (
  GskTransform $self,
  gfloat       $out_dx is rw,
  gfloat       $out_dy is rw
)
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_transform (GskTransform $next, GskTransform $other)
  returns GskTransform
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_transform_bounds (
  GskTransform    $self,
  graphene_rect_t $rect,
  graphene_rect_t $out_rect
)
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_transform_point (
  GskTransform     $self,
  graphene_point_t $point,
  graphene_point_t $out_point
)
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_translate (
  GskTransform     $next,
  graphene_point_t $point
)
  returns GskTransform
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_translate_3d (
  GskTransform       $next,
  graphene_point3d_t $point
)
  returns GskTransform
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_unref (GskTransform $self)
  is      native(gsk)
  is      export
{ * }
