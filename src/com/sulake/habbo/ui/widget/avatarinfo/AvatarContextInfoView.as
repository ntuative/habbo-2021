package com.sulake.habbo.ui.widget.avatarinfo
{
    import com.sulake.habbo.ui.widget.contextmenu.ContextInfoView;
    import com.sulake.habbo.ui.widget.contextmenu.IContextMenuParentWidget;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import flash.geom.Rectangle;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.habbo.friendlist.RelationshipStatusEnum;

    public class AvatarContextInfoView extends ContextInfoView 
    {

        protected var _SafeStr_1887:int;
        protected var _userName:String;
        protected var _SafeStr_3881:int;
        protected var _SafeStr_3882:Boolean;
        protected var _SafeStr_3883:int;

        public function AvatarContextInfoView(_arg_1:IContextMenuParentWidget)
        {
            super(_arg_1);
            _SafeStr_1324 = (_arg_1 as AvatarInfoWidget);
        }

        public static function setup(_arg_1:AvatarContextInfoView, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:int, _arg_6:Boolean=false):void
        {
            _arg_1._SafeStr_1887 = _arg_2;
            _arg_1._userName = _arg_3;
            _arg_1._SafeStr_3881 = _arg_5;
            _arg_1._SafeStr_3883 = _arg_4;
            _arg_1._SafeStr_3882 = _arg_6;
            setupContext(_arg_1);
        }


        public function get userId():int
        {
            return (_SafeStr_1887);
        }

        public function get userType():int
        {
            return (_SafeStr_3881);
        }

        public function get roomIndex():int
        {
            return (_SafeStr_3883);
        }

        public function get userName():String
        {
            return (_userName);
        }

        public function get allowNameChange():Boolean
        {
            return (_SafeStr_3882);
        }

        override protected function updateWindow():void
        {
            var _local_1:XML;
            if ((((!(_SafeStr_1324)) || (!(_SafeStr_1324.assets))) || (!(_SafeStr_1324.windowManager))))
            {
                return;
            };
            if (!_window)
            {
                _local_1 = (_SafeStr_1324.assets.getAssetByName("avatar_info_widget").content as XML);
                _window = (_SafeStr_1324.windowManager.buildFromXML(_local_1, 0) as IWindowContainer);
                if (!_window)
                {
                    return;
                };
            };
            var _local_2:IWindow = _window.findChildByName("name");
            _local_2.caption = _userName;
            updateRelationshipStatus();
            _window.findChildByName("change_name_container").visible = false;
            _window.height = 39;
            activeView = _window;
        }

        override protected function getOffset(_arg_1:Rectangle):int
        {
            var _local_2:int = -(_SafeStr_3884.height);
            if (((_SafeStr_3881 == 1) || (_SafeStr_3881 == 3)))
            {
                _local_2 = (_local_2 + ((_arg_1.height > 50) ? 25 : 0));
            }
            else
            {
                _local_2 = (_local_2 - 4);
            };
            return (_local_2);
        }

        protected function updateRelationshipStatus():void
        {
            var _local_1:IStaticBitmapWrapperWindow;
            if (((_SafeStr_1324) && (_SafeStr_1324.friendList)))
            {
                _local_1 = IStaticBitmapWrapperWindow(_window.findChildByName("relationship_status"));
                _local_1.assetUri = ("relationship_status_" + RelationshipStatusEnum.statusAsString(_SafeStr_1324.friendList.getRelationshipStatus(userId)));
            };
        }


    }
}

