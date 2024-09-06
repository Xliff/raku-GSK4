use v6.c;

use Graphene::Rect;
#use GDK::Augment::Pixbuf:ver<4>;
#use GDK::Pixbuf;
use GDK::Texture:ver<4>;
use GTK::Application:ver<4>;
use GTK::Image:ver<4>;

my $blur-inc;

sub MAIN (
  $filename = "{ $*HOME }/Pictures/DB/idylic.png",
  $frames = 120
) {
  die "Image '{ $filename }' not found!" unless $filename.IO.r;

  my $app = GTK::Application.new(
    title  => 'GSK Blur',
    width  => 1024,
    height => 768
  );

  $a.Activate.tap: SUB {
    # $texture = GDK::Pixbuf.new-from-file($filename);
    # $anim    = GDK::Pixbuf::Animation::Simple;
    my $blur-max = min($texture.width, $texture.height);

    $blur-inc = $blur-max / ($frames * 0.5);

    my $r = GSK::Blur.new(
      GSK::Texture.new(
        $texture,
        Graphene::Rect.new(0, 0, $texture.width, $texture.height)
      ),
      0
    );
    my $p = $r.to-paintable;
    say "CS: { $p.compute-concrete-size(1024, 768).gist }";

    my $s = GTK::Snapshot.new;
    $s.append-node($r);

    my $i = GTK::Image.new;
    $i.paintable = $p;

    $app.window.child = $i;

    GLib::Timeout.add(10, sub {
      #renderFrame($r);
      $i.save;

      my $nr = $r.radius;
      $nr += $blur-inc;
      if $nr > $blur-max || $nr < 0 {
        $blur-inc = -$blur-inc;
        $nr = 0         if $nr < 0;
        $nr = $blur-max if $nr > $blur-max;
      }
      $r.radius = $nr;

      $i.restore;
      G_SOURCE_CONTINUE;
    });
  }

  $app.run;

  # $anim.set-loop($true);
  # say 'Done';
}
