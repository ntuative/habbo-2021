package com.sulake.habbo.inventory.badges
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.window.widgets.IBadgeImageWidget;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.core.window.events.WindowEvent;

    public class Badge 
    {

        private static const THUMB_COLOR_NORMAL:int = 0xCCCCCC;
        private static const THUMB_COLOR_UNSEEN:int = 10275685;

        public static var _SafeStr_622:IWindowContainer;

        private var _SafeStr_573:Boolean = false;
        private var _badgeId:String;
        private var _isInUse:Boolean;
        private var _isSelected:Boolean;
        private var _window:IWindowContainer;
        private var _SafeStr_1277:IWindow;
        private var _isUnseen:Boolean;
        private var _badgeName:String;
        private var _badgeDescription:String;
        private var _SafeStr_1275:BadgesModel;

        public function Badge(_arg_1:BadgesModel, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:Boolean)
        {
            _SafeStr_1275 = _arg_1;
            _badgeId = _arg_2;
            _badgeName = _arg_3;
            _badgeDescription = _arg_4;
            _isUnseen = _arg_5;
            this.isSelected = false;
        }

        public function dispose():void
        {
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
        }

        public function get badgeId():String
        {
            return (_badgeId);
        }

        public function get badgeName():String
        {
            return (_badgeName);
        }

        public function get badgeDescription():String
        {
            return (_badgeDescription);
        }

        public function get isInUse():Boolean
        {
            return (_isInUse);
        }

        public function get isSelected():Boolean
        {
            return (_isSelected);
        }

        public function get window():IWindowContainer
        {
            if (!_SafeStr_573)
            {
                initWindow();
            };
            return (_window);
        }

        private function initWindow():void
        {
            _window = (_SafeStr_622.clone() as IWindowContainer);
            IBadgeImageWidget(IWidgetWindow(_window.findChildByName("badge")).widget).badgeId = badgeId;
            _window.findChildByName("badge").visible = true;
            _SafeStr_1277 = _window.findChildByTag("BG_COLOR");
            _SafeStr_573 = true;
            _window.procedure = itemEventProc;
        }

        private function itemEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            switch (_arg_1.type)
            {
                case "WME_CLICK":
                    _SafeStr_1275.setBadgeSelected(this.badgeId);
                    return;
            };
        }

        public function set isInUse(_arg_1:Boolean):void
        {
            _isInUse = _arg_1;
        }

        public function set isSelected(_arg_1:Boolean):void
        {
            _isSelected = _arg_1;
            if (((_SafeStr_1277 == null) || (_window == null)))
            {
                return;
            };
            _SafeStr_1277.color = ((_isUnseen) ? 10275685 : 0xCCCCCC);
            _window.findChildByName("outline").visible = _arg_1;
        }

        public function set isUnseen(_arg_1:Boolean):void
        {
            if (_isUnseen != _arg_1)
            {
                _isUnseen = _arg_1;
                this.isSelected = _isSelected;
            };
        }


    }
}

