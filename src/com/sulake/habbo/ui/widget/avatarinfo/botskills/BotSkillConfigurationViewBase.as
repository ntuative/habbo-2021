package com.sulake.habbo.ui.widget.avatarinfo.botskills
{
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.ui.widget.avatarinfo.AvatarInfoWidget;
    import com.sulake.core.window.IWindowContainer;
    import flash.geom.Rectangle;
    import com.sulake.habbo.communication.messages.parser.room.bots.BotCommandConfigurationEvent;
    import com.sulake.habbo.communication.messages.outgoing.room.bots.GetBotCommandConfigurationDataComposer;
    import flash.geom.Point;

    public class BotSkillConfigurationViewBase implements BotSkillConfigurationView 
    {

        private var _SafeStr_3879:IMessageEvent;
        protected var _SafeStr_1324:AvatarInfoWidget;
        protected var _window:IWindowContainer;
        protected var _SafeStr_1917:int;

        public function BotSkillConfigurationViewBase(_arg_1:AvatarInfoWidget)
        {
            _SafeStr_1324 = _arg_1;
        }

        public function dispose():void
        {
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
            if (_SafeStr_1324)
            {
                if (((_SafeStr_1324.handler.container.connection) && (_SafeStr_3879)))
                {
                    _SafeStr_1324.handler.container.connection.removeMessageEvent(_SafeStr_3879);
                    _SafeStr_3879 = null;
                };
                _SafeStr_1324 = null;
            };
            _SafeStr_1917 = -1;
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_1324 == null);
        }

        public function open(_arg_1:int, _arg_2:Point=null):void
        {
            var _local_3:XML;
            var _local_4:Rectangle;
            _SafeStr_1917 = _arg_1;
            if (!_SafeStr_3879)
            {
                _SafeStr_3879 = new BotCommandConfigurationEvent(onBotCommandConfigurationEvent);
                _SafeStr_1324.handler.container.connection.addMessageEvent(_SafeStr_3879);
            };
            _SafeStr_1324.handler.container.connection.send(new GetBotCommandConfigurationDataComposer(_SafeStr_1917, skillType));
            if (!_window)
            {
                _local_3 = (_SafeStr_1324.assets.getAssetByName(windowAssetName).content as XML);
                _window = (_SafeStr_1324.windowManager.buildFromXML(_local_3, 1) as IWindowContainer);
            };
            if (_arg_2)
            {
                _local_4 = _window.rectangle;
                _window.x = (_arg_2.x - (_local_4.width / 2));
                _window.y = (_arg_2.y - _local_4.height);
            };
            fitToScreen();
            _window.visible = true;
            deactivateInputs();
        }

        public function close():void
        {
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
        }

        public function parseConfiguration(_arg_1:String):void
        {
        }

        protected function deactivateInputs():void
        {
        }

        protected function get windowAssetName():String
        {
            return ("");
        }

        protected function get skillType():int
        {
            return (-1);
        }

        private function onBotCommandConfigurationEvent(_arg_1:BotCommandConfigurationEvent):void
        {
            if (((_arg_1.getParser().botId == _SafeStr_1917) && (_arg_1.getParser().commandId == skillType)))
            {
                parseConfiguration(_arg_1.getParser().data);
            };
        }

        private function fitToScreen():void
        {
            var _local_1:Rectangle = new Rectangle();
            _window.getGlobalRectangle(_local_1);
            if (_local_1.top < 0)
            {
                _window.y = (_window.y + -(_local_1.top));
            };
            if (_local_1.left < 0)
            {
                _window.x = (_window.x + -(_local_1.left));
            };
            if (_local_1.right > _window.desktop.width)
            {
                _window.x = (_window.x - (_local_1.right - _window.desktop.width));
            };
            if (_local_1.bottom > _window.desktop.height)
            {
                _window.y = (_window.y - (_local_1.bottom - _window.desktop.height));
            };
        }


    }
}

