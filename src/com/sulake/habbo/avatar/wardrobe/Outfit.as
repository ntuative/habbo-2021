package com.sulake.habbo.avatar.wardrobe
{
    import com.sulake.habbo.avatar.IOutfit;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.IAvatarImage;

    public class Outfit implements IOutfit, IAvatarImageListener 
    {

        private var _SafeStr_1284:HabboAvatarEditor;
        private var _figure:String;
        private var _gender:String;
        private var _view:OutfitView;
        private var _disposed:Boolean;

        public function Outfit(_arg_1:HabboAvatarEditor, _arg_2:String, _arg_3:String)
        {
            _SafeStr_1284 = _arg_1;
            _view = new OutfitView(_arg_1.manager.windowManager, _arg_1.manager.assets, (!(_arg_2 == "")));
            switch (_arg_3)
            {
                case "M":
                case "m":
                case "M":
                    _arg_3 = "M";
                    break;
                case "F":
                case "f":
                case "F":
                    _arg_3 = "F";
            };
            _figure = _arg_2;
            _gender = _arg_3;
            update();
        }

        public function dispose():void
        {
            if (_view)
            {
                _view.dispose();
                _view = null;
            };
            _figure = null;
            _gender = null;
            _disposed = true;
            _SafeStr_1284 = null;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function update():void
        {
            var _local_1:BitmapData;
            var _local_3:Boolean = _SafeStr_1284.manager.getBoolean("zoom.enabled");
            var _local_2:IAvatarImage = _SafeStr_1284.manager.avatarRenderManager.createAvatarImage(figure, ((_local_3) ? "h" : "sh"), _gender, this);
            if (_local_2)
            {
                _local_2.setDirection("full", 4);
                _local_1 = _local_2.getImage("full", true, ((_local_3) ? 0.5 : 1));
                if (((_view) && (_local_1)))
                {
                    _view.update(_local_1);
                };
                _local_2.dispose();
            };
        }

        public function get figure():String
        {
            return (_figure);
        }

        public function get gender():String
        {
            return (_gender);
        }

        public function get view():OutfitView
        {
            return (_view);
        }

        public function avatarImageReady(_arg_1:String):void
        {
            update();
        }


    }
}

