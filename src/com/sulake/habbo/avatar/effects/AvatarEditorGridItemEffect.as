package com.sulake.habbo.avatar.effects
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.avatar.IHabboAvatarEditorAvatarEffect;
    import flash.display.BitmapData;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.ITextWindow;
    import flash.geom.Rectangle;

    public class AvatarEditorGridItemEffect 
    {

        private var _window:IWindowContainer;
        private var _SafeStr_1277:IWindow;
        private var _SafeStr_1288:Boolean = false;
        private var _SafeStr_1289:IHabboAvatarEditorAvatarEffect;

        public function AvatarEditorGridItemEffect(_arg_1:IHabboAvatarEditorAvatarEffect, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary)
        {
            _window = IWindowContainer(_arg_2.buildFromXML((_arg_3.getAssetByName("avatar_editor_effect_griditem_xml").content as XML)));
            _SafeStr_1277 = _window.findChildByTag("BG_COLOR");
            _SafeStr_1289 = _arg_1;
            if (_arg_1 != null)
            {
                bitmap = _arg_1.icon;
                amount = _arg_1.amountInInventory;
                if (_arg_1.isPermanent)
                {
                    setSecondsLeft(_arg_1.duration, _arg_1.duration);
                }
                else
                {
                    if (_arg_1.isActive)
                    {
                        setSecondsLeft(_arg_1.secondsLeft, _arg_1.duration);
                    };
                };
            }
            else
            {
                bitmap = BitmapData(_arg_2.assets.getAssetByName("avatar_editor_generic_remove_selection").content);
                amount = 1;
            };
            selected = false;
            _window.addEventListener("WME_OVER", onMouseOver);
            _window.addEventListener("WME_OUT", onMousetOut);
        }

        public function get effectType():int
        {
            return ((_SafeStr_1289 != null) ? _SafeStr_1289.type : -1);
        }

        private function onMousetOut(_arg_1:WindowMouseEvent):void
        {
            if (!_SafeStr_1288)
            {
                _SafeStr_1277.visible = false;
            };
            _SafeStr_1277.blend = 1;
        }

        private function onMouseOver(_arg_1:WindowMouseEvent):void
        {
            if (!_SafeStr_1288)
            {
                _SafeStr_1277.visible = true;
                _SafeStr_1277.blend = 0.5;
            };
        }

        public function get window():IWindow
        {
            return (_window);
        }

        public function set selected(_arg_1:Boolean):void
        {
            _SafeStr_1288 = _arg_1;
            _SafeStr_1277.visible = _SafeStr_1288;
            _SafeStr_1277.blend = 1;
        }

        private function set bitmap(_arg_1:BitmapData):void
        {
            IBitmapWrapperWindow(_window.findChildByName("bitmap")).bitmap = _arg_1;
        }

        private function set amount(_arg_1:int):void
        {
            var _local_2:IWindowContainer = IWindowContainer(_window.findChildByName("effect_amount_bg1"));
            var _local_3:ITextWindow = ITextWindow(_window.findChildByName("effect_amount"));
            _local_2.visible = (_arg_1 > 1);
            _local_3.text = _arg_1.toString();
        }

        private function setSecondsLeft(_arg_1:int, _arg_2:int):void
        {
            _window.findChildByName("duration_container").visible = true;
            var _local_5:IBitmapWrapperWindow = IBitmapWrapperWindow(_window.findChildByName("progress_bar"));
            var _local_3:BitmapData = new BitmapData(_local_5.width, _local_5.height, false, 0);
            var _local_4:Rectangle = new Rectangle(0, 0, int((_local_3.width * (_arg_1 / _arg_2))), _local_3.height);
            _local_3.fillRect(_local_4, 2146080);
            _local_5.bitmap = _local_3;
        }


    }
}

