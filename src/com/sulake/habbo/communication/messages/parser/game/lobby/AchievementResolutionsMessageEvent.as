package com.sulake.habbo.communication.messages.parser.game.lobby
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class AchievementResolutionsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function AchievementResolutionsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, AchievementResolutionsMessageParser);
        }

        public function getParser():AchievementResolutionsMessageParser
        {
            return (this._SafeStr_816 as AchievementResolutionsMessageParser);
        }


    }
}

