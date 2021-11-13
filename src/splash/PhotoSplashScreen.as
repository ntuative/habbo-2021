package splash
{
    import flash.display.Sprite;
    import __AS3__.vec.Vector;
    import flash.display.Bitmap;
    import flash.display.DisplayObjectContainer;

    public class PhotoSplashScreen extends Sprite 
    {

        private var splashBgClass:Class = HabboPhotoSplashScreen_Habbosplash_bg_class_png;
        private var splashTopClass:Class = HabboPhotoSplashScreen_Habbosplash_top_class_png;
        private var splashImg1:Class = HabboPhotoSplashScreen_Habbosplash_img1_png;
        private var splashImg2:Class = HabboPhotoSplashScreen_Habbosplash_img2_png;
        private var splashImg3:Class = HabboPhotoSplashScreen_Habbosplash_img3_png;
        private var splashImg4:Class = HabboPhotoSplashScreen_Habbosplash_img4_png;
        private var splashImg5:Class = HabboPhotoSplashScreen_Habbosplash_img5_png;
        private var splashImg6:Class = HabboPhotoSplashScreen_Habbosplash_img6_png;
        private var splashImg7:Class = HabboPhotoSplashScreen_Habbosplash_img7_png;
        private var splashImg8:Class = HabboPhotoSplashScreen_Habbosplash_img8_png;
        private var splashImg9:Class = HabboPhotoSplashScreen_Habbosplash_img9_png;
        private var splashImg10:Class = HabboPhotoSplashScreen_Habbosplash_img10_png;
        private var splashImg11:Class = HabboPhotoSplashScreen_Habbosplash_img11_png;
        private var splashImg12:Class = HabboPhotoSplashScreen_Habbosplash_img12_png;
        private var splashImg13:Class = HabboPhotoSplashScreen_Habbosplash_img13_png;
        private var splashImg14:Class = HabboPhotoSplashScreen_Habbosplash_img14_png;
        private var splashImg15:Class = HabboPhotoSplashScreen_Habbosplash_img15_png;
        private var splashImg16:Class = HabboPhotoSplashScreen_Habbosplash_img16_png;
        private var splashImg17:Class = HabboPhotoSplashScreen_Habbosplash_img17_png;
        private var splashImg18:Class = HabboPhotoSplashScreen_Habbosplash_img18_png;
        private var splashImg19:Class = HabboPhotoSplashScreen_Habbosplash_img19_png;
        private var splashImg20:Class = HabboPhotoSplashScreen_Habbosplash_img20_png;
        private var splashImg21:Class = HabboPhotoSplashScreen_Habbosplash_img21_png;
        private var splashImg22:Class = HabboPhotoSplashScreen_Habbosplash_img22_png;
        private var splashImg23:Class = HabboPhotoSplashScreen_Habbosplash_img23_png;
        private var splashImg24:Class = HabboPhotoSplashScreen_Habbosplash_img24_png;
        private var splashImg25:Class = HabboPhotoSplashScreen_Habbosplash_img25_png;
        private var splashImg26:Class = HabboPhotoSplashScreen_Habbosplash_img26_png;
        private var splashImg27:Class = HabboPhotoSplashScreen_Habbosplash_img27_png;
        private var splashImg28:Class = HabboPhotoSplashScreen_Habbosplash_img28_png;
        private var splashImg29:Class = HabboPhotoSplashScreen_Habbosplash_img29_png;
        private var splashImg30:Class = HabboPhotoSplashScreen_Habbosplash_img30_png;

        public function PhotoSplashScreen(_arg_1:DisplayObjectContainer)
        {
            super();
            var _local_3:Bitmap = null;
            var _local_2:Vector.<Bitmap> = new Vector.<Bitmap>(0);
            _local_3 = (new splashBgClass() as Bitmap);
            _local_2.push(_local_3);
            var _local_4:Class = (this[("splashImg" + int((1 + Math.floor((Math.random() * 30)))))] as Class);
            if (_local_4 != null)
            {
                _local_3 = new _local_4();
                _local_3.x = 96;
                _local_3.y = 51;
                _local_2.push(_local_3);
            };
            _local_3 = (new splashTopClass() as Bitmap);
            _local_2.push(_local_3);
            for each (_local_3 in _local_2)
            {
                addChild(_local_3);
            };
        }

    }
}