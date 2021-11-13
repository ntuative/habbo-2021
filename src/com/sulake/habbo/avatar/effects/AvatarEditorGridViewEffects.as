package com.sulake.habbo.avatar.effects
{
    import com.sulake.habbo.avatar.common.IAvatarEditorGridView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
    import com.sulake.core.window.components.IItemGridWindow;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.avatar.IHabboAvatarEditorAvatarEffect;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.avatar.common.*;

    public class AvatarEditorGridViewEffects implements IAvatarEditorGridView 
    {

        private var _window:IWindowContainer;
        private var _firstView:Boolean = true;
        private var _SafeStr_1275:IAvatarEditorCategoryModel;
        private var _SafeStr_1283:String;
        private var _SafeStr_1282:IItemGridWindow;
        private var _effectItems:Vector.<AvatarEditorGridItemEffect>;
        private var _notification:IWindow;
        private var _SafeStr_906:IWindow;

        public function AvatarEditorGridViewEffects(_arg_1:IWindowContainer)
        {
            _window = _arg_1;
            _SafeStr_1282 = (_window.findChildByName("thumbs") as IItemGridWindow);
            _notification = _window.findChildByName("content_notification");
            _SafeStr_906 = _window.findChildByName("content_title");
        }

        public function dispose():void
        {
            if (_SafeStr_1282)
            {
                _SafeStr_1282.dispose();
                _SafeStr_1282 = null;
            };
            _SafeStr_1275 = null;
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
        }

        public function get window():IWindowContainer
        {
            return (_window);
        }

        public function initFromList(_arg_1:IAvatarEditorCategoryModel, _arg_2:String):void
        {
            var _local_5:AvatarEditorGridItemEffect;
            _SafeStr_1275 = _arg_1;
            _SafeStr_1283 = _arg_2;
            _window.visible = true;
            var _local_3:Array = EffectsModel(_SafeStr_1275).effects;
            _SafeStr_1282.removeGridItems();
            _effectItems = new Vector.<AvatarEditorGridItemEffect>();
            if (_local_3.length == 0)
            {
                _SafeStr_906.visible = true;
                _notification.visible = true;
            }
            else
            {
                _notification.visible = false;
                _SafeStr_906.visible = false;
                _local_5 = new AvatarEditorGridItemEffect(null, _SafeStr_1275.controller.manager.windowManager, _SafeStr_1275.controller.manager.assets);
                addGridItem(_local_5);
                for each (var _local_4:IHabboAvatarEditorAvatarEffect in _local_3)
                {
                    _local_5 = new AvatarEditorGridItemEffect(_local_4, _SafeStr_1275.controller.manager.windowManager, _SafeStr_1275.controller.manager.assets);
                    addGridItem(_local_5);
                };
            };
            showPalettes(0);
            _firstView = false;
        }

        private function addGridItem(_arg_1:AvatarEditorGridItemEffect):void
        {
            _arg_1.window.procedure = partEventProc;
            _effectItems.push(_arg_1);
            _SafeStr_1282.addGridItem(_arg_1.window);
        }

        public function showPalettes(_arg_1:int):void
        {
            var _local_3:IWindow = _window.findChildByName("palette0");
            var _local_2:IWindow = _window.findChildByName("palette1");
            _local_3.visible = false;
            _local_2.visible = false;
        }

        public function get firstView():Boolean
        {
            return (_firstView);
        }

        public function updateSelection(_arg_1:int, _arg_2:Boolean):void
        {
            if (((_arg_1 >= 0) && (_arg_1 < _effectItems.length)))
            {
                _effectItems[_arg_1].selected = _arg_2;
            };
        }

        public function getGridIndex(_arg_1:int):int
        {
            var _local_2:int;
            _local_2 = 0;
            while (_local_2 < _effectItems.length)
            {
                if (_effectItems[_local_2].effectType == _arg_1)
                {
                    return (_local_2);
                };
                _local_2++;
            };
            return (-1);
        }

        private function partEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:int;
            if (_arg_1.type == "WME_DOWN")
            {
                _local_3 = _SafeStr_1282.getGridItemIndex(_arg_1.window);
                _SafeStr_1275.selectPart(_SafeStr_1283, _local_3);
            };
        }


    }
}

