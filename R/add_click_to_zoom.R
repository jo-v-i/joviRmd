#' Add closeup image overlay
#'
#' Add HTML that enables the user to click an image to bring up a large overlay of that image without needing to go to another page.
#' @export
add_click_to_zoom = function() {
  cat('
<!-- Click to zoom -->
<style>
#zoomedContainer {
  top: 50%;
  left: 50%;
  position: fixed;
  transform: translate(-50%, -50%);

  box-shadow: 0px 0px 50px #888888;
  max-height:95vh;
  opacity: 0;
  z-index: 50;
}
.zoomImg {
  width: 100%;
  max-height:95vh;
  cursor: zoom-out;
}
img:not(.zoomImg) { cursor: zoom-in; }
</style>

<script type="text/javascript">
  $(document).ready(function() {
    $("body").prepend("<div id=\"zoomedContainer\"><img src=\"\" class=\"zoomImg\"></div>");
    // click event handler for all figures (imgs)
    $("img:not(.zoomImg)").click(function() {
      $(".zoomImg").attr("src", $(this).attr("src"));
      $(".zoomedContainer").css({opacity: "1", width: "95%"});
    });
    // click event handler for zoomImg
    $("img.zoomImg").click(function() {
      $(".zoomedContainer").css({opacity: "0", width: "0%"});
    });
  });
</script>
      ')
}
