package com.sulake.habbo.communication.messages.parser.crafting
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CraftingRecipesAvailableMessageParser implements IMessageParser 
    {

        private var _recipeComplete:Boolean;
        private var _count:int;


        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _count = _arg_1.readInteger();
            _recipeComplete = _arg_1.readBoolean();
            return (true);
        }

        public function flush():Boolean
        {
            _count = 0;
            _recipeComplete = false;
            return (true);
        }

        public function get count():int
        {
            return (_count);
        }

        public function get recipeComplete():Boolean
        {
            return (_recipeComplete);
        }


    }
}