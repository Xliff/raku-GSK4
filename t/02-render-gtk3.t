use v6.c;

use GDK::Augment::Pixbuf:ver<4>;
use GDK::Pixbuf;
use GDK::Texture:ver<4>;
use Graphene::Rect;
use GTK::Application;
use GTK::DrawingArea;

my ($anim, $texture);

sub renderFrame ($r, $i) {
  my $s  = Cairo::Surface.create(
    CAIRO_FORMAT_ARGB32,
    $texture.width,
    $texture.height
  );
  my $cr = Cairo::Context.create($s);

  # Take new context and create pixbuf frame
  $r.render($cr);

  $r.render($cr);
  $r.radius += $i

  # Add frame to animation
  $anim.add-frame(
    GDK::Pixubuf.get-from-surface($s)
  );
}

sub MAIN (
  $filename = "{ $*HOME }/Pictures/DB/idylic.png",
  $frames = 120
) {
  die "Image '{ $filename }' not found!" unless $filename.IO.r;

  $texture = GDK::Pixbuf.new-from-file($filename);
  $anim    = GDK::Pixbuf::Animation::Simple;

  my $blur-max = min($texture.width, $texture.height);
  my $blur-inc = $blur-max / ($frames * 0.5)

  my $r = GSK::Blur.new(
    GSK::Texture.new(
      $texture,
      Graphene::Rect.new(0, 0, $texture.width, $texture.height)
    ),
    0
  );

  renderFrame($r,  $blur-inc) for ^($frames / 2);
  renderFrame($r, -$blur-inc) for ^($frames / 2);

  $anim.set-loop($true);
  say 'Done';
}
