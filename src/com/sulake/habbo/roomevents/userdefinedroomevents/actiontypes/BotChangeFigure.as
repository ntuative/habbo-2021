package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes
{
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.habbo.window.widgets.IAvatarImageWidget;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class BotChangeFigure extends DefaultActionType 
    {

        private static const STRING_PARAM_DELIMITER:String = "\t";

        private var _SafeStr_659:HabboUserDefinedRoomEvents;
        private var _figureString:String;
        private var _botName:String;
        private var _window:IWindowContainer;


        override public function get code():int
        {
            return (_SafeStr_226.BOT_CHANGE_FIGURE);
        }

        override public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl.STUFF_SELECTION_OPTION_NONE);
        }

        override public function onInit(_arg_1:IWindowContainer, _arg_2:HabboUserDefinedRoomEvents):void
        {
            _SafeStr_659 = _arg_2;
        }

        override public function readStringParamFromForm(_arg_1:IWindowContainer):String
        {
            var _local_2:String = getInput(_arg_1, "bot_name").text;
            return ((_local_2 + "\t") + _figureString);
        }

        override public function onEditStart(_arg_1:IWindowContainer, _arg_2:Triggerable):void
        {
            var _local_3:Array = _arg_2.stringParam.split("\t");
            if (_local_3.length > 0)
            {
                _botName = _local_3[0];
            };
            if (_local_3.length > 1)
            {
                _figureString = _local_3[1];
            };
            getInput(_arg_1, "bot_name").text = _botName;
            IAvatarImageWidget(IWidgetWindow(_arg_1.findChildByName("avatar_image")).widget).figure = _figureString;
            _arg_1.findChildByName("capture_figure").procedure = captureFigureButtonProcedure;
            _window = _arg_1;
        }

        override public function get hasSpecialInputs():Boolean
        {
            return (true);
        }

        private function getInput(_arg_1:IWindowContainer, _arg_2:String):ITextFieldWindow
        {
            return (ITextFieldWindow(_arg_1.findChildByName(_arg_2)));
        }

        private function captureFigureButtonProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _figureString = _SafeStr_659.sessionDataManager.figure;
                IAvatarImageWidget(IWidgetWindow(_window.findChildByName("avatar_image")).widget).figure = _figureString;
            };
        }


    }
}

