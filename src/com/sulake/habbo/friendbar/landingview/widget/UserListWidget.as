package com.sulake.habbo.friendbar.landingview.widget
{
    import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.incoming.quest.ILandingPageUserEntry;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.IAvatarImageWidget;
    import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.friendbar.landingview.*;

    public class UserListWidget implements ILandingViewWidget 
    {

        private var _landingView:HabboLandingView;
        private var _container:IWindowContainer;
        private var _popup:IWindowContainer;
        private var _startOffset:int = 150;
        private var _SafeStr_2378:Array = [0, 10, 5, 0, 5, 10, 0, 10, 5, 10];
        private var _SafeStr_2379:Array = [];
        private var _SafeStr_2380:Array = [2, 4, 2, 2, 4, 2, 2, 2, 4, 2];

        public function UserListWidget(_arg_1:HabboLandingView)
        {
            _landingView = _arg_1;
        }

        public function get container():IWindow
        {
            return (_container);
        }

        public function dispose():void
        {
            _landingView = null;
            _container = null;
            if (_popup != null)
            {
                _popup.dispose();
                _popup = null;
            };
        }

        public function initialize():void
        {
            _container = IWindowContainer(_landingView.getXmlWindow("user_list"));
            registerMessageListeners();
        }

        public function refresh():void
        {
        }

        public function get disposed():Boolean
        {
            return (_landingView == null);
        }

        public function refreshContent():void
        {
            if (users == null)
            {
                _container.visible = false;
                return;
            };
            _container.visible = true;
            refreshList();
            backToDefaultPopup();
        }

        private function refreshList():void
        {
            var _local_5:int;
            var _local_6:IWindowContainer;
            var _local_1:ILandingPageUserEntry;
            var _local_3:IWidgetWindow;
            var _local_4:IAvatarImageWidget;
            var _local_2:int = _startOffset;
            _local_5 = 0;
            while (_local_5 < 10)
            {
                _local_6 = getAvatarContainer(_local_5);
                if (_local_6 == null)
                {
                    _local_6 = createAvatarContainer(_local_5);
                    _container.addChild(_local_6);
                    _local_6.x = _local_2;
                    _local_2 = (_local_2 + _local_6.width);
                };
                _local_1 = users[_local_5];
                _local_6.visible = (!(_local_1 == null));
                if (_local_1)
                {
                    _local_3 = IWidgetWindow(_local_6.findChildByName("avatar_image_widget"));
                    _local_4 = IAvatarImageWidget(_local_3.widget);
                    _local_4.figure = _local_1.figure;
                };
                _local_5++;
            };
        }

        private function getAvatarContainer(_arg_1:int):IWindowContainer
        {
            return (IWindowContainer(_container.getChildByID(_arg_1)));
        }

        private function createAvatarContainer(_arg_1:int):IWindowContainer
        {
            var _local_3:IWindowContainer = IWindowContainer(_landingView.getXmlWindow("user_entry"));
            setupVariation(_local_3, _arg_1);
            _local_3.procedure = onEntry;
            _local_3.id = _arg_1;
            if (_SafeStr_2379.length > _arg_1)
            {
                _local_3.width = _SafeStr_2379[_arg_1];
            };
            var _local_2:IWindow = _local_3.findChildByName("extra_link_region");
            _local_2.visible = hasExtraLink();
            _local_2.procedure = onExtraLink;
            _local_2.id = _arg_1;
            return (_local_3);
        }

        private function setupVariation(_arg_1:IWindowContainer, _arg_2:int):void
        {
            var _local_3:IWidgetWindow = IWidgetWindow(_arg_1.findChildByName("avatar_image_widget"));
            var _local_4:IAvatarImageWidget = IAvatarImageWidget(_local_3.widget);
            _arg_1.y = (_arg_1.y + (_SafeStr_2378[_arg_2] + 70));
            if (_SafeStr_2378[_arg_2] < 0)
            {
                _arg_1.height = (_arg_1.height + -(_SafeStr_2378[_arg_2]));
            };
            _local_4.direction = _SafeStr_2380[_arg_2];
            _arg_1.findChildByName("extra_link_region").y = (_arg_1.findChildByName("extra_link_region").y - _SafeStr_2378[_arg_2]);
        }

        private function getEntry(_arg_1:IWindow):ILandingPageUserEntry
        {
            var _local_2:int = _arg_1.id;
            return (users[_local_2]);
        }

        private function onEntry(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:ILandingPageUserEntry = getEntry(_arg_2);
            if (_local_3 == null)
            {
                return;
            };
            if (_arg_1.type == "WME_CLICK")
            {
                _landingView.send(new GetExtendedProfileMessageComposer(_local_3.userId));
            }
            else
            {
                if (_arg_1.type == "WME_OVER")
                {
                    showPopup(_local_3, _arg_2);
                }
                else
                {
                    if (_arg_1.type == "WME_OUT")
                    {
                        backToDefaultPopup();
                    };
                };
            };
        }

        private function onExtraLink(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:ILandingPageUserEntry;
            if (_arg_1.type == "WME_CLICK")
            {
                _local_3 = getEntry(_arg_2);
                if (_local_3 == null)
                {
                    return;
                };
                extraLinkClicked(_local_3);
            }
            else
            {
                onEntry(_arg_1, _arg_2.parent);
            };
        }

        private function showPopup(_arg_1:ILandingPageUserEntry, _arg_2:IWindow):void
        {
            if (_popup == null)
            {
                _popup = IWindowContainer(_landingView.getXmlWindow(getPopupXml()));
                _container.addChild(_popup);
            };
            refreshPopup(_arg_1, _popup);
            _popup.y = Math.max(0, (79 - _popup.height));
            _popup.x = (_arg_2.x + ((_arg_2.width - _popup.width) / 2));
            _popup.visible = true;
        }

        private function backToDefaultPopup():void
        {
            if (users.length > 0)
            {
                showPopup(users[0], _container.getChildByID(0));
            }
            else
            {
                if (_popup != null)
                {
                    _popup.visible = false;
                };
            };
        }

        protected function get landingView():HabboLandingView
        {
            return (_landingView);
        }

        protected function getText(_arg_1:String):String
        {
            return (("${" + _arg_1) + "}");
        }

        protected function registerMessageListeners():void
        {
        }

        protected function get users():Array
        {
            return (null);
        }

        protected function refreshPopup(_arg_1:ILandingPageUserEntry, _arg_2:IWindowContainer):void
        {
        }

        protected function getPopupXml():String
        {
            return (null);
        }

        protected function hasExtraLink():Boolean
        {
            return (false);
        }

        protected function extraLinkClicked(_arg_1:ILandingPageUserEntry):void
        {
        }

        protected function set avatarOffsetsY(_arg_1:Array):void
        {
            _SafeStr_2378 = _arg_1;
        }

        protected function set avatarContainerWidths(_arg_1:Array):void
        {
            _SafeStr_2379 = _arg_1;
        }

        public function set startOffset(_arg_1:int):void
        {
            _startOffset = _arg_1;
        }


    }
}

