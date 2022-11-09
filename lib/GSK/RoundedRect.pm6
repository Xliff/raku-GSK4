use v6.c;

use Method::Also;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RoundedRect:ver<4>;

use GLib::Roles::Implementor;

class GSK::RoundedRect:ver<4> {
  also does GLib::Roles::Implementor;

  has GskRoundedRect $!gsk-rr is implementor;

  submethod BUILD ( :$gsk-rounded-rect ) {
    $!gsk-rr = $gsk-rounded-rect if $gsk-rounded-rect
  }

  method GSK::Raw::Structs::GskRoundedRect
    is also<GskRoundedRect>
  { $!gsk-rr }

  multi method new (GskRoundedRect $gsk-rounded-rect, :$ref = True) {
    return Nil unless $gsk-rounded-rect;

    my $o = self.bless( :$gsk-rounded-rect );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    graphene_rect_t() $bounds,
    Num()             $radius
  ) {
    my $gsk-rounded-rect = ::?CLASS.init(GskRoundedRect.new, $bounds, $radius);

    $gsk-rounded-rect ?? self.bless( :$gsk-rounded-rect ) !! Nil;
  }
  multi method new (
    graphene_rect_t() $bounds,
    graphene_size_t() $top_left,
    graphene_size_t() $top_right,
    graphene_size_t() $bottom_right,
    graphene_size_t() $bottom_left
  ) {
    my $gsk-rounded-rect = ::?CLASS.init(
      GskRoundedRect.new,
      $bounds,
      $top_left,
      $top_right,
      $bottom_right,
      $bottom_left
    );

    $gsk-rounded-rect ?? self.bless( :$gsk-rounded-rect ) !! Nil;
  }

  method contains_point (graphene_point_t() $point) is also<contains-point> {
    so gsk_rounded_rect_contains_point($!gsk-rr, $point);
  }

  method contains_rect (graphene_rect_t() $rect) is also<contains-rect> {
    so gsk_rounded_rect_contains_rect($!gsk-rr, $rect);
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      ::?CLASS.init_copy(GskGroundedRect.new, $!gsk-rr),
      $raw,
      |self.getTypePair
    );
  }

  method init (
    GskRoundedRect()  $self
    graphene_rect_t() $bounds,
    graphene_size_t() $top_left,
    graphene_size_t() $top_right,
    graphene_size_t() $bottom_right,
    graphene_size_t() $bottom_left
  )
    is static
  {
    gsk_rounded_rect_init(
      $self,
      $bounds,
      $top_left,
      $top_right,
      $bottom_right,
      $bottom_left
    );
    $self
  }

  method init_copy (
    GskRoundedRect()  $dest,
    GskRoundedRect()  $src,
                     :$raw    = False
  )
    is static

    is also<init-copy>
  {
    propReturnObject(
      gsk_rounded_rect_init_copy($dest, $src),
      $raw,
      |self.getTypePair
    );
  }

  method init_from_rect (
    GskRoundedRect()  $self,
    graphene_rect_t() $bounds,
    Num()             $radius
  )
    is static

    is also<init-from-rect>
  {
    my gfloat $r = $radius;

    gsk_rounded_rect_init_from_rect($self, $bounds, $r);
  }

  method intersects_rect (graphene_rect_t() $rect) is also<intersects-rect> {
    so ogsk_rounded_rect_intersects_rect($!gsk-rr, $rect);
  }

  method is_rectilinear is also<is-rectilinear> {
    so gsk_rounded_rect_is_rectilinear($!gsk-rr);
  }

  method normalize {
    gsk_rounded_rect_normalize($!gsk-rr);
  }

  method offset (
    Num() :$dx  = 0,
    Num() :$dy  = 0,
          :$raw = False
  ) {
    samewith($dx, $dy, :$false);
  }
  method offset (
    Num()  $dx,
    Num()  $dy,
          :$raw = False
  ) {
    my gfloat ($ddx, $ddy) = ($dx, $dy);

    propReturnObject(
      gsk_rounded_rect_offset($!gsk-rr, $ddx, $ddy),
      $raw,
      |self.getTypePair
    );
  }

  multi method grow (
    Num() :t(:$top)    = 0,
    Num() :r(:$right)  = 0,
    Num() :b(:$bottom) = 0,
    Num() :l(:$left)   = 0,
             :$raw     = False
  ) {
    samewith($top, $right, $bottom, $left, :$raw);
  }
  multi method grow (
    Num() $top    = 0,
    Num() $right  = 0,
    Num() $bottom = 0,
    Num() $left   = 0,
          $raw    = False
  ) {
    self.shrink(-$top, -$right, -$bottom, -$left, :$raw);
  }
  multi method shrink (
    Num() :t(:$top)    = 0,
    Num() :r(:$right)  = 0,
    Num() :b(:$bottom) = 0,
    Num() :l(:$left)   = 0,
             :$raw     = False
  ) {
    samewith($top, $right, $bottom, $left, :$raw);
  }
  multi method shrink (
    Num()  $top,
    Num()  $right,
    Num()  $bottom,
    Num()  $left,
          :$raw     = False
  ) {
    my gfloat ($t, $r, $b, $l) = ($top, $right, $bottom, $left);

    propReturnObject(
      gsk_rounded_rect_shrink($!gsk-rr, $t, $r, $b, $l),
      $raw,
      |self.getTypePair
    );
  }

}
