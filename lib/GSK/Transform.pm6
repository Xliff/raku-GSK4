use v6.c;

use NativeCall;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::Transform:ver<4>;

use GLib::Roles::Implementor;

class GSK::Transform:ver<4> {
  has GskTransform $!gsk-t is implementor;

  submethod BUILD ( :$gsk-transform ) {
    $!gsk-t = $gsk-transform if $gsk-transform;
  }

  method GSK::Raw::Structs::Definitions
  { $!gsk-t }

  multi method new (GskTransform $gsk-transform) {
    $gsk-transform ?? self.bless( :$gsk-transform ) !! Nil;
  }
  multi method new {
    my $gsk-transform = gsk_transform_new();

    $gsk-transform ?? self.bless( :$gsk-transform ) !! Nil;
  }

  method equal (GskTransform() $second) {
    gsk_transform_equal($!gsk-t, $second);
  }

  method get_category ( :$enum = True ) {
    my $c = gsk_transform_get_category($!gsk-t);
    return $c unless $enum;
    GskTransformCatetoryEnum($c);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_transform_get_type, $n, $t );
  }

  method invert ( :$raw = False ) {
    propReturnObject(
      gsk_transform_invert($!gsk-t),
      $raw,
      |self.getTypePair
    );
  }

  method matrix (graphene_matrix_t() $matrix, :$raw = False) {
    propReturnObject(
      gsk_transform_matrix($!gsk-t, $matrix),
      $raw,
      |self.getTypePair
    );
  }

  multi method parse ( :$raw = False ) {
    samewith(
      newCArray( Pointer[GskTransform] ),
      :$raw
    );
  }
  multi method parse (
    CArray[Pointer[GskTransform]]  $out_transform,
                                  :$raw            = False
  ) {
    gsk_transform_parse($!gsk-t, $out_transform);

    propReturnObject(
      ppr( $out_transform[0] ),
      $raw,
      |self.getTypePair
    );
  }

  method perspective (Num() $depth, :$raw = False) {
    my gfloat $d = $depth;

    propReturnObject(
      gsk_transform_perspective($!gsk-t, $d),
      $raw,
      |self.getTypePair
    );
  }

  method print (GString() $string) {
    gsk_transform_print($!gsk-t, $string);
  }

  method ref {
    gsk_transform_ref($!gsk-t);
    self
  }

  method rotate (Num() $angle, :$raw = False) {
    my gfloat $a = $angle;

    propReturnObject(
      gsk_transform_rotate($!gsk-t, $angle),
      $raw,
      |self.getTypePair
    );
  }

  method rotate_3d (Num() $angle, graphene_vec3_t() $axis) {
    my gfloat $a = $angle;

    propReturnObject(
      gsk_transform_rotate_3d($!gsk-t, $angle, $axis),
      $raw,
      |self.getTypePair
    );
  }

  method scale (Num() $factor_x, Num() $factor_y = $factor_x, :$raw = False) {
    my gfloat ($fx, $fy) = ($factor_x, $factor_y);

    propReturnObject(
      gsk_transform_scale($!gsk-t, $fx, $fy),
      $raw,
      |self.getTypePair
    );
  }

  method scale_3d (
    Num()       $factor_x,
    Num()       $factor_y  = $factor_x,
    Num()       $factor_z  = $factor_x
  ) {
    my gfloat ($fx, $fy, $fz) = ($factor_x, $factor_y, $factor_z);

    propReturnObject(
      gsk_transform_scale_3d($!gsk-t, $fx, $fy, $fz),
      $raw,
      |self.getTypePair
    );
  }

  method skew (
    Num()  $skew_x,
    Num()  $skew_y  = $skew_x
          :$raw     = False
  ) {
    my gfloat ($sx, $sy) = ($skew_x, $skew_y);

    propReturnObject(
      gsk_transform_skew($!gsk-t, $skew_x, $skew_y),
      $raw,
      |self.getTypePair
    );
  }

  proto method to_2d (|)
  { * }

  multi method to_2d {
    samewith($, $, $, $, $, $);
  }
  multi method to_2d (
    $out_xx is rw,
    $out_yx is rw,
    $out_xy is rw,
    $out_yy is rw,
    $out_dx is rw,
    $out_dy is rw
  ) {
    my gfloat ($xx, $yx, $xy, $yy, $dx, $dy) = 0e0 xx 6;

    gsk_transform_to_2d($!gsk-t, $out_xx, $out_yx, $out_xy, $out_yy, $out_dx, $out_dy);

    ($out_xx, $out_yx, $out_xy, $out_yy, $out_dx, $out_dy) =
      ($xx, $yx, $xy, $yy, $dx, $dy);
  }

  proto method to_2d_components (|)
  { * }

  multi method to_2d_components (
    samewith($, $, $, $, $, $, $);
  }
  multi method to_2d_components (
    $out_skew_x  is rw,
    $out_skew_y  is rw,
    $out_scale_x is rw,
    $out_scale_y is rw,
    $out_angle   is rw,
    $out_dx      is rw,
    $out_dy      is rw
  ) {
    my gfloat ($skx, $sky, $sx, $sy, $a, $dx, $dy) = 0e0 xx 7;

    gsk_transform_to_2d_components($!gsk-t, $skx, $sky, $sx, $sy, $a, $dx, $dy);

    ($out_skew_x,  $out_skew_y,
     $out_scale_x, $out_scale_y,
     $out_angle,
     $out_dx,      $out_dy)      = ($skx, $sky, $sx, $sy, $a, $dx, $dy)
  }

  proto method to_affine (|)
  { * }

  multi method to_affine {
    samewith($, $, $, $);
  }
  multi method to_affine (
    $out_scale_x is rw,
    $out_scale_y is rw,
    $out_dx      is rw,
    $out_dy      is rw
  ) {
    my gfloat ($sx, $sy, $dx, $dy) = 0e0 xx 4;

    gsk_transform_to_affine($!gsk-t, $sx, $sy, $dx, $dy);

    ($out_scale_x, $out_scale_y, $out_dx, $out_dy) = ($sx, $sy, $dx, $dy);
  }

  proto method to_matrix (|)
  { * }

  method to_matrix {
    samewith(Graphene::Matrix.alloc);
  }
  method to_matrix (graphene_matrix_t() $out_matrix) {
    gsk_transform_to_matrix($!gsk-t, $out_matrix);
  }

  method to_string {
    gsk_transform_to_string($!gsk-t);
  }

  proto method to_translate (|)
  { * }

  multi method to_translate {
    samewith($, $);
  }
  multi method to_translate (
    $out_dx is rw,
    $out_dy is rw
  ) {
    my gfloat ($dx, $dy) = 0e0 xx 2;

    gsk_transform_to_translate($!gsk-t, $dx, $dy);

    ($out_dx, $out_dy) = ($dx, $dy)
  }

  method transform (GskTransform() $other, :$raw = False) {
    propReturnObject(
      gsk_transform_transform($!gsk-t, $other),
      $raw,
      |self.getTypePair
    );
  }

  proto method transform_bounds (|)
  { * }

  multi method transform_bounds (graphene_rect_t() $rect, :$raw = False) {
    samewith($rect, Graphene::Rect.alloc, :$raw);
  }
  multi method transform_bounds (
    graphene_rect_t()  $rect,
    graphene_rect_t()  $out_rect,
                      :$raw       = False
  ) {
    gsk_transform_transform_bounds($!gsk-t, $rect, $out_rect);
  }

  proto method transform_point (|)
  { * }

  method transform_point (graphene_point_t() $point, :$raw = False) {
    samewith($point, Graphene::Point.alloc, :$raw);
  }
  method transform_point (
    graphene_point_t()  $point,
    graphene_point_t()  $out_point,
                       :$raw        = False
  ) {

    gsk_transform_transform_point($!gsk-t, $point, $out_point);
    propReturnObject($out_point, $raw, |Graphene::Point.getTypePair);
  }

  method translate (graphene_point_t() $point, :$raw = False) {
    propReturnObject(
      gsk_transform_translate($!gsk-t, $point),
      $raw,
      |self.getTypePair
    );
  }

  method translate_3d (graphene_point3d_t() $point, :$raw = False) {
    propReturnObject(
      gsk_transform_translate_3d($!gsk-t, $point),
      $raw,
      |self.getTypePair
    );
  }

  method unref {
    gsk_transform_unref($!gsk-t);
  }

}
