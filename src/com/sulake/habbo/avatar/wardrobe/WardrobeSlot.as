package com.sulake.habbo.avatar.wardrobe
{
    import com.sulake.habbo.avatar.IOutfit;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.IWindow;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.geom.Matrix;
    import com.sulake.core.window.components._SafeStr_143;
    import com.sulake.core.window.events.WindowEvent;

    public class WardrobeSlot implements IOutfit, IAvatarImageListener 
    {

        private var _SafeStr_1284:HabboAvatarEditor;
        private var _figure:String;
        private var _gender:String;
        private var _SafeStr_1357:Boolean;
        private var _view:IWindowContainer;
        private var _SafeStr_1358:IBitmapWrapperWindow;
        private var _id:int;
        private var _disposed:Boolean;

        public function WardrobeSlot(_arg_1:IWindow, _arg_2:HabboAvatarEditor, _arg_3:int, _arg_4:Boolean, _arg_5:String=null, _arg_6:String=null)
        {
            _SafeStr_1284 = _arg_2;
            _id = _arg_3;
            createView(_arg_1);
            update(_arg_5, _arg_6, _arg_4);
        }

        public function get id():int
        {
            return (_id);
        }

        public function update(_arg_1:String, _arg_2:String, _arg_3:Boolean):void
        {
            switch (_arg_2)
            {
                case "M":
                case "m":
                case "M":
                    _arg_2 = "M";
                    break;
                case "F":
                case "f":
                case "F":
                    _arg_2 = "F";
            };
            _figure = _arg_1;
            _gender = _arg_2;
            _SafeStr_1357 = _arg_3;
            updateView();
        }

        private function createView(_arg_1:IWindow):void
        {
            _view = (_arg_1.clone() as IWindowContainer);
            _view.procedure = eventHandler;
            _view.visible = false;
            _SafeStr_1358 = (_view.findChildByName("image") as IBitmapWrapperWindow);
        }

        public function dispose():void
        {
            _SafeStr_1284 = null;
            _figure = null;
            _gender = null;
            _SafeStr_1358 = null;
            if (_view)
            {
                _view.dispose();
                _view = null;
            };
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function updateView():void
        {
            var _local_1:BitmapData;
            var _local_5:IAvatarImage;
            var _local_9:BitmapDataAsset;
            var _local_3:int;
            var _local_4:int;
            var _local_8:Boolean = true;
            var _local_6:Boolean = _SafeStr_1284.manager.getBoolean("zoom.enabled");
            if (((_figure) && (_SafeStr_1357)))
            {
                _local_5 = _SafeStr_1284.manager.avatarRenderManager.createAvatarImage(figure, ((_local_6) ? "h" : "sh"), _gender, this);
                if (_local_5)
                {
                    _local_5.setDirection("full", 4);
                    _local_1 = _local_5.getCroppedImage("full", ((_local_6) ? 0.5 : 1));
                    _local_5.dispose();
                };
            }
            else
            {
                _local_9 = (_SafeStr_1284.manager.windowManager.assets.getAssetByName("avatar_editor_wardrobe_empty_slot") as BitmapDataAsset);
                if (_local_9)
                {
                    _local_1 = (_local_9.content as BitmapData);
                    _local_8 = false;
                };
            };
            if (!_local_1)
            {
                return;
            };
            if (_SafeStr_1358)
            {
                if (_SafeStr_1358.bitmap)
                {
                    _SafeStr_1358.bitmap.dispose();
                };
                _SafeStr_1358.bitmap = new BitmapData(_SafeStr_1358.width, _SafeStr_1358.height, true, 0);
                _local_3 = int(((_SafeStr_1358.width - _local_1.width) / 2));
                _local_4 = int(((_SafeStr_1358.height - _local_1.height) / 2));
                _SafeStr_1358.bitmap.draw(_local_1, new Matrix(1, 0, 0, 1, _local_3, _local_4));
            };
            if (_local_8)
            {
                _local_1.dispose();
            };
            var _local_7:_SafeStr_143 = (_view.findChildByName("set_button") as _SafeStr_143);
            if (_local_7)
            {
                _local_7.visible = _SafeStr_1357;
            };
            var _local_2:_SafeStr_143 = (_view.findChildByName("get_button") as _SafeStr_143);
            if (_local_2)
            {
                _local_2.visible = ((_SafeStr_1357) && (!(_figure == null)));
            };
        }

        private function eventHandler(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            if (!_SafeStr_1284.verifyClubLevel())
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "set_button":
                    _figure = _SafeStr_1284.figureData.getFigureString();
                    _gender = _SafeStr_1284.gender;
                    _SafeStr_1284.handler.saveWardrobeOutfit(_id, this);
                    updateView();
                    return;
                case "get_button":
                case "get_figure":
                    if (_figure)
                    {
                        _SafeStr_1284.loadAvatarInEditor(_figure, _gender, _SafeStr_1284.clubMemberLevel);
                    };
                    return;
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

        public function get view():IWindowContainer
        {
            return (_view);
        }

        public function avatarImageReady(_arg_1:String):void
        {
            updateView();
        }


    }
}

