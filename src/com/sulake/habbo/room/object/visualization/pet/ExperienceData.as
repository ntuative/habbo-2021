package com.sulake.habbo.room.object.visualization.pet
{
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.text.TextFormat;
    import flash.text.TextField;
    import flash.geom.Matrix;

    public class ExperienceData 
    {

        private var _image:BitmapData;
        private var _SafeStr_3419:Boolean;
        private var _SafeStr_3420:BitmapData;
        private var _amount:int = -1;
        private var _alpha:int;

        public function ExperienceData(_arg_1:BitmapData, _arg_2:Boolean=true)
        {
            _image = _arg_1;
            _SafeStr_3419 = _arg_2;
            if (_image != null)
            {
                _SafeStr_3420 = _image.clone();
            };
            setExperience(0);
        }

        public function dispose():void
        {
            if (_SafeStr_3420)
            {
                _SafeStr_3420.dispose();
                _SafeStr_3420 = null;
            };
            if (_image != null)
            {
                if (_SafeStr_3419)
                {
                    _image.dispose();
                };
                _image = null;
            };
        }

        public function get alpha():int
        {
            return (_alpha);
        }

        public function set alpha(_arg_1:int):void
        {
            _alpha = _arg_1;
        }

        public function get image():BitmapData
        {
            return (_image);
        }

        public function setExperience(_arg_1:int):void
        {
            if (((_amount == _arg_1) || (_image == null)))
            {
                return;
            };
            _image.copyPixels(_SafeStr_3420, _SafeStr_3420.rect, new Point(0, 0));
            var _local_2:TextFormat = new TextFormat();
            _local_2.font = "Volter";
            _local_2.color = 0xFFFFFF;
            _local_2.size = 9;
            var _local_3:TextField = new TextField();
            _local_3.embedFonts = true;
            _local_3.width = 30;
            _local_3.height = 12;
            _local_3.background = true;
            _local_3.backgroundColor = 0xE6C0B500;
            _local_3.defaultTextFormat = _local_2;
            _local_3.text = ("+" + _arg_1);
            var _local_4:Matrix = new Matrix();
            _local_4.translate(15, 19);
            _image.draw(_local_3, _local_4);
        }


    }
}

