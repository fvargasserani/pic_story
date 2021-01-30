# *AUTENTICACION MANUAL*

rails new project

Descomentar gema bcrypt en el Gemfile

bundle

rails g model User email password_digest

verificar migración y ahí mismo agregar t.index :email, unique: true (para que no se repita el email)

Anadir rails g migration addModelRefToAttribute model:references

rails db:migrate

modelo user.rb agregar metodo has_secure_password y agregar validates :email presence: true, uniqueness: {case_sensitive: true }

abrir la consola con rails c

    User.create(email: 'test@example.com') => esto trae un rollback

    Para ver los errores hacemos:
    usuario = _
    usuario.errors.message (nos indica que el password no puede estar en blanco)

    Crearemos un nuevo usuario con password y password_confirmation

    user.authenticate('cualquierPassword)
    => false

    Si ponemos la clave correcta, arrojara el objeto con el usuario que acabamos de crear. El password_digest viene codificado (encriptado).

rails g controller Sessions view create destroy

rails g controller Home index

En config > routes.rb . Borraremos las rutas sessions, para usar REST. Pondremos resources:sessions, only [:new, :create, :destroy]. 'home#index' lo dejaremos como root.

En application_controller agregamos
    helper_method :current_user
    protected
        def current user
            @current_user ||= User.find(session[:user_id]) if session[:user_id]
        end

En la vista index de Home pondremos
current_user? y mensajes de bienvenida

En la vista index de Home agregamos botones con condicion if para:
- Log out con el <% if %> <%= link_to 'Log out', session_path(current_user), method :delete %>
(siempre verificamos en rails routes el nombre del path).
- Log in  <% else %> <%= link_to 'Log in', new_session_path %> <% end %>

En la vista new de sessions hacer un formulario para crear un usuario con clave. Usar los helpers:
    label_tag
    email_field_tag
    password_tag

En el controlador de sessions, definimos:

def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
        session[:user_id] = user.id (guardamos el dato del usuario que acabamos de encontrar)
        redirect_to root_path, notice 'logeado correctamente'
    else
        flash.now[:notice] = 'Email o password invalido'
        render action: :new
    end
end

def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Signed out successfully'
end

En la carpeta layouts ir al documento application e indicar todos los mensajes flash que recibamos.

