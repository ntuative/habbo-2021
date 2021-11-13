package com.sulake.habbo.ui.widget.effects
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IScrollableListWindow;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.ui.handler.EffectsWidgetHandler;
    import com.sulake.core.assets.XmlAsset;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.ui.widget.memenu.IWidgetAvatarEffect;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class EffectsWidget extends RoomWidgetBase 
    {

        private static const LIST_HEIGHT_MAX:int = 320;
        private static const LIST_HEIGHT_MIN:int = 48;
        private static const TOOLBAR_MARGIN:int = 2;

        private var _SafeStr_570:IWindowContainer;
        private var _SafeStr_853:IScrollableListWindow;
        private var _SafeStr_4017:Map;

        public function EffectsWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.handler.widget = this;
            _SafeStr_4017 = new Map();
        }

        public function get handler():EffectsWidgetHandler
        {
            return (_SafeStr_3915 as EffectsWidgetHandler);
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            if (_SafeStr_4017)
            {
                for each (var _local_1:EffectView in _SafeStr_4017)
                {
                    _local_1.dispose();
                };
                _SafeStr_4017.dispose();
                _SafeStr_4017 = null;
            };
            _SafeStr_853 = null;
            if (_SafeStr_570)
            {
                _SafeStr_570.dispose();
                _SafeStr_570 = null;
            };
            super.dispose();
        }

        public function open():void
        {
            var _local_2:XmlAsset;
            var _local_1:Rectangle;
            var _local_3:IWindow;
            if (!_SafeStr_570)
            {
                _local_2 = (assets.getAssetByName("effects_widget") as XmlAsset);
                _SafeStr_570 = (windowManager.buildFromXML((_local_2.content as XML)) as IWindowContainer);
                _local_1 = handler.container.toolbar.getRect();
                _SafeStr_570.x = (_local_1.right + 2);
                _SafeStr_570.y = (_local_1.bottom - _SafeStr_570.height);
                _SafeStr_853 = (_SafeStr_570.findChildByName("list") as IScrollableListWindow);
                _local_3 = _SafeStr_570.findChildByName("close");
                _local_3.addEventListener("WME_CLICK", onClose);
            };
            update();
            _SafeStr_570.visible = true;
        }

        public function update():void
        {
            var _local_1:EffectView;
            var _local_4:int;
            var _local_2:Array = this.handler.container.inventory.getAvatarEffects();
            for each (var _local_3:IWidgetAvatarEffect in _local_2)
            {
                _local_1 = (_SafeStr_4017.getValue(_local_3.type) as EffectView);
                if (_local_1)
                {
                    _local_1.update();
                }
                else
                {
                    _local_1 = new EffectView(this, _local_3);
                    _SafeStr_4017.add(_local_3.type, _local_1);
                    _SafeStr_853.addListItem(_local_1.window);
                };
            };
            _local_4 = (_SafeStr_4017.length - 1);
            while (_local_4 >= 0)
            {
                _local_1 = _SafeStr_4017.getWithIndex(_local_4);
                if (_local_2.indexOf(_local_1.effect) == -1)
                {
                    _SafeStr_853.removeListItem(_local_1.window);
                    _SafeStr_4017.remove(_SafeStr_4017.getKey(_local_4));
                    _local_1.dispose();
                };
                _local_4--;
            };
            var _local_5:int = _SafeStr_853.scrollableRegion.height;
            _SafeStr_853.height = Math.max(Math.min(_local_5, 320), 48);
            _SafeStr_570.findChildByName("no_effects").visible = (_local_2.length == 0);
        }

        public function selectEffect(_arg_1:int, _arg_2:Boolean):void
        {
            if (_arg_2)
            {
                handler.container.inventory.setEffectDeselected(_arg_1);
            }
            else
            {
                handler.container.inventory.setEffectSelected(_arg_1);
            };
        }

        private function onClose(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_570.visible = false;
        }


    }
}

