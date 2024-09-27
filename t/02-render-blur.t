use v6.c;

use GSK::Raw::Types:ver<4>;

use GLib::Timeout;
use Graphene::Rect;
# use GDK::Augment::Pixbuf:ver<4>;
use GDK::Pixbuf;
use GDK::Texture:ver<4>;
use GSK::Node::Blur:ver<4>;
use GSK::Node::Texture:ver<4>;
use GTK::Snapshot:ver<4>;
use GTK::Application:ver<4>;
use GTK::Image:ver<4>;

my ($blur-inc, $radius) = (0, 0);

my $rect;

sub update-image ($i, $t, $radius = 0) {
  my $r = GSK::Node::Blur.new(
    GSK::Node::Texture.new( GDK::Texture.new-for-pixbuf($t), $rect ),
    $radius
  );

  my $s = GTK::Snapshot.new;
  $s.append-node($r);
  $i.paintable = $s.to-paintable($rect);
}

sub MAIN (
   $filename = "{ $*HOME }/Pictures/Digital Blasphemy/idylic.png",
  :$frames   = 120
) {
  die "Image '{ $filename }' not found!" unless $filename.IO.r;

  my $app = GTK::Application.new(
    title  => 'GSK Blur',
    width  => 1024,
    height => 768
  );

  $app.Activate.tap: SUB {
    my $texture = GDK::Pixbuf.new-from-file($filename);

    my $blur-max = min( .width, .height ) / 4 given $texture;
    $blur-inc = $blur-max / ($frames * 0.5);

    $rect = Graphene::Rect.new(0, 0, .width, .height) given $texture;

    my $i = GTK::Image.new;
    update-image($i, $texture);

    $app.window.child = $i;
    $app.window.present;

    GLib::Timeout.add(10, SUB {
      CATCH { default { .message.say; .backtrace.concise.say } }

      $radius += $blur-inc;
      if $radius > $blur-max || $radius < 0 {
        $blur-inc = -$blur-inc;
        $radius = 0         if $radius < 0;
        $radius = $blur-max if $radius > $blur-max;
      }
      update-image($i, $texture, $radius);

      G_SOURCE_CONTINUE;
    });
  }

  $app.run;

  # $anim.set-loop($true);
  # say 'Done';
}
