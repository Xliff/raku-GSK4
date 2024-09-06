use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::Path::Measure:ver<4>;

use GLib::Roles::Implementor;

class GSK::Path::Measure {
  also does GLib::Roles::Implementor;

  has GskPathMeasure $!gsk-pm is implementor;

  multi method new (GskPath() $p) {
    my $gsk-path-measure = gsk_path_measure_new($p);

    $gsk-path-measure ?? self.bless( :$gsk-path-measure ) !! Nil;
  }

  method new_with_tolerance (GskPath() $p, gfloat  $tolerance) {
    my gfloat $t = $tolerance;

    my $gsk-path-measure = gsk_path_measure_new_with_tolerance($p, $t);

    $gsk-path-measure ?? self.bless( :$gsk-path-measure ) !! Nil;
  }

  method get_length {
    gsk_path_measure_get_length($!gsk-pm);
  }

  method get_path {
    gsk_path_measure_get_path($!gsk-pm);
  }

  method get_point (Num() $distance, GskPathPoint() $result) {
    my gfloat $d = $distance;

    gsk_path_measure_get_point($!gsk-pm, $d, $result);
  }

  method get_tolerance {
    gsk_path_measure_get_tolerance($!gsk-pm);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_path_measure_get_type, $n, $t );
  }

  method ref {
    gsk_path_measure_ref($!gsk-pm);
    self;
  }

  method unref {
    gsk_path_measure_unref($!gsk-pm);
  }

}
