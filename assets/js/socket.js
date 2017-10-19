// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/web/endpoint.ex":
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "lib/web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "lib/web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/2" function
// in "lib/web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, pass the token on connect as below. Or remove it
// from connect if you don't care about authentication.

socket.connect()

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("updates:all", {})

const newMessage = function({message_content, message_user, user_show, message_show}) {
  let m = document.createElement("tr")
  
  let m_content = document.createElement("td")
  m_content.innerText = message_content
  
  let m_user = document.createElement("td")
  let m_user_show = document.createElement("a")
  m_user_show.href = user_show
  m_user_show.innerText = message_user
  m_user.apprendChild(m_user_show)

  
  let m_show = document.createElement("td")
  m_show.className = "text-right"
  let m_show_span = document.createElement("span")
  let m_show_link = document.createElement("a")
  m_show_link.href = message_show
  m_show_link.className = "btn btn-default btn-xs"
  m_show_link.innerText = "Show"
  m_show_span.appendChild(m_show_link)
  m_show.appendChild(m_show_span)


  m.appendChild(m_content)
  m.appendChild(m_user)
  m.appendChild(m_show)

  return m
}

 channel.on("new_m", payload => {
 let newM = newMessage(payload)
 $("#messages").prepend(newM)
})

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

export default socket
