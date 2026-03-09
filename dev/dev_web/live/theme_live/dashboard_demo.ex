defmodule DevWeb.ThemeLive.DashboardDemo do
  @moduledoc false

  use Phoenix.Component

  # Atoms
  import Bioma.Atoms.Button
  import Bioma.Atoms.Badge
  import Bioma.Atoms.Input
  import Bioma.Atoms.Label
  import Bioma.Atoms.Separator, only: [separator: 1]
  import Bioma.Atoms.Switch, only: [switch: 1]
  import Bioma.Atoms.Checkbox, only: [checkbox: 1]
  import Bioma.Atoms.Slider, only: [slider: 1]
  import Bioma.Atoms.Avatar
  import Bioma.Atoms.Toggle, only: [toggle: 1]
  import Bioma.Atoms.ToggleGroup
  import Bioma.Atoms.Kbd, only: [kbd: 1]
  import Bioma.Atoms.Textarea, only: [textarea: 1]
  import Bioma.Atoms.Skeleton, only: [skeleton: 1]
  import Bioma.Atoms.RadioGroup

  # Molecules
  import Bioma.Molecules.Card
  import Bioma.Molecules.Tabs
  import Bioma.Molecules.Dialog
  import Bioma.Molecules.Select
  import Bioma.Molecules.Progress, only: [progress: 1]
  import Bioma.Molecules.Accordion
  import Bioma.Molecules.Alert
  import Bioma.Molecules.Chart, only: [chart: 1]
  import Bioma.Molecules.Calendar, only: [calendar: 1]
  import Bioma.Molecules.Table
  import Bioma.Molecules.Carousel
  import Bioma.Molecules.Pagination
  import Bioma.Molecules.Tree
  import Bioma.Molecules.MarkdownEditor
  import Bioma.Molecules.Kanban

  attr :dark_mode, :boolean, default: false
  attr :calendar_month, :any, default: nil
  attr :calendar_selected, :any, default: nil
  attr :demo_plan, :string, default: "free"
  attr :demo_terms, :boolean, default: false
  attr :demo_page, :integer, default: 1
  attr :demo_bold, :boolean, default: true
  attr :demo_italic, :boolean, default: false
  attr :demo_underline, :boolean, default: false
  attr :demo_align, :string, default: "left"
  attr :demo_notif, :map, default: %{}
  attr :demo_markdown, :string, default: ""
  attr :demo_preview_html, :string, default: nil

  def dashboard_demo(assigns) do
    ~H"""
    <div class="columns-1 md:columns-2 xl:columns-3 gap-6 [&>*]:break-inside-avoid [&>*]:mb-6">
      <%!-- Block 1: Stats Cards --%>
      <.stats_block />

      <%!-- Block 2: Bar Chart --%>
      <.chart_block />

      <%!-- Block 3: Profile Card --%>
      <.profile_block />

      <%!-- Block 4: Recent Sales --%>
      <.recent_sales_block />

      <%!-- Block 5: Create Account Form --%>
      <.form_block plan={@demo_plan} terms={@demo_terms} />

      <%!-- Block 6: Calendar --%>
      <.calendar_block month={@calendar_month} selected={@calendar_selected} />

      <%!-- Block 7: Invoice Table --%>
      <.table_block page={@demo_page} />

      <%!-- Block 8: Buttons & Dialog --%>
      <.interactive_block />

      <%!-- Block 9: Login Card --%>
      <.login_block />

      <%!-- Block 10: Notification Settings --%>
      <.notifications_block notif={@demo_notif} />

      <%!-- Block 11: Keyboard Shortcuts --%>
      <.shortcuts_block />

      <%!-- Block 12: Accordion FAQ --%>
      <.accordion_block />

      <%!-- Block 13: Tabs --%>
      <.tabs_block />

      <%!-- Block 14: Alerts --%>
      <.alerts_block />

      <%!-- Block 15: Progress & Loading --%>
      <.progress_block />

      <%!-- Block 16: Shipping Address --%>
      <.shipping_block />

      <%!-- Block 17: Toolbar --%>
      <.toolbar_block bold={@demo_bold} italic={@demo_italic} underline={@demo_underline} align={@demo_align} />

      <%!-- Block 18: 404 / Empty State --%>
      <.empty_state_block />

      <%!-- Block 19: Badges & Slider --%>
      <.badges_block />

      <%!-- Block 20: Carousel --%>
      <.carousel_block />

      <%!-- Block 21: Tree View --%>
      <.tree_view_block />

      <%!-- Block 22: Markdown Editor --%>
      <.markdown_editor_block markdown={@demo_markdown} preview_html={@demo_preview_html} />
    </div>

    <%!-- Block 23: Kanban Board (full-width, outside the masonry grid) --%>
    <div class="mt-6">
      <.kanban_board_block />
    </div>
    """
  end

  # ── Block 1: Stats Cards ──────────────────────────────────────────────

  defp stats_block(assigns) do
    ~H"""
    <div class="space-y-4">
      <.card>
        <.card_header class="flex flex-row items-center justify-between pb-2">
          <.card_title class="text-sm font-medium">Total Revenue</.card_title>
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-muted-foreground"><line x1="12" x2="12" y1="2" y2="22"/><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/></svg>
        </.card_header>
        <.card_content>
          <div class="text-2xl font-bold">$45,231.89</div>
          <p class="text-xs text-muted-foreground">+20.1% from last month</p>
        </.card_content>
      </.card>
      <.card>
        <.card_header class="flex flex-row items-center justify-between pb-2">
          <.card_title class="text-sm font-medium">Subscriptions</.card_title>
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-muted-foreground"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
        </.card_header>
        <.card_content>
          <div class="text-2xl font-bold">+2,350</div>
          <p class="text-xs text-muted-foreground">+180.1% from last month</p>
        </.card_content>
      </.card>
      <.card>
        <.card_header class="flex flex-row items-center justify-between pb-2">
          <.card_title class="text-sm font-medium">Active Now</.card_title>
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-muted-foreground"><path d="M22 12h-4l-3 9L9 3l-3 9H2"/></svg>
        </.card_header>
        <.card_content>
          <div class="text-2xl font-bold">+573</div>
          <p class="text-xs text-muted-foreground">+201 since last hour</p>
        </.card_content>
      </.card>
    </div>
    """
  end

  # ── Block 2: Bar Chart ────────────────────────────────────────────────

  defp chart_block(assigns) do
    ~H"""
    <.card>
      <.card_header>
        <.card_title>Overview</.card_title>
        <.card_description>Monthly revenue for the current year.</.card_description>
      </.card_header>
      <.card_content>
        <.chart
          id="demo-revenue-chart"
          type="bar"
          data={[
            %{label: "Jan", value: 4000},
            %{label: "Feb", value: 3000},
            %{label: "Mar", value: 5200},
            %{label: "Apr", value: 4500},
            %{label: "May", value: 6100},
            %{label: "Jun", value: 5500},
            %{label: "Jul", value: 4800},
            %{label: "Aug", value: 5900},
            %{label: "Sep", value: 6400},
            %{label: "Oct", value: 5100},
            %{label: "Nov", value: 7200},
            %{label: "Dec", value: 6800}
          ]}
          height="300px"
        />
      </.card_content>
    </.card>
    """
  end

  # ── Block 3: Profile Card ─────────────────────────────────────────────

  defp profile_block(assigns) do
    ~H"""
    <.card>
      <.card_content class="pt-6">
        <div class="flex flex-col items-center text-center">
          <.avatar class="h-20 w-20">
            <.avatar_fallback class="text-2xl">JD</.avatar_fallback>
          </.avatar>
          <h3 class="mt-4 text-lg font-semibold">Jane Doe</h3>
          <p class="text-sm text-muted-foreground">Senior Engineer</p>
          <div class="mt-3 flex gap-2">
            <.badge>Elixir</.badge>
            <.badge variant="secondary">Phoenix</.badge>
            <.badge variant="outline">LiveView</.badge>
          </div>
          <p class="mt-4 text-sm text-muted-foreground">
            Building real-time applications with Elixir and Phoenix LiveView.
            Open source enthusiast.
          </p>
          <div class="mt-4 flex gap-2 w-full">
            <.button class="flex-1">Follow</.button>
            <.button variant="outline" class="flex-1">Message</.button>
          </div>
        </div>
      </.card_content>
    </.card>
    """
  end

  # ── Block 4: Recent Sales ─────────────────────────────────────────────

  defp recent_sales_block(assigns) do
    ~H"""
    <.card>
      <.card_header>
        <.card_title>Recent Sales</.card_title>
        <.card_description>You made 265 sales this month.</.card_description>
      </.card_header>
      <.card_content>
        <div class="space-y-4">
          <div :for={sale <- mock_sales()} class="flex items-center gap-4">
            <.avatar>
              <.avatar_fallback>{sale.initials}</.avatar_fallback>
            </.avatar>
            <div class="flex-1 min-w-0">
              <p class="text-sm font-medium leading-none">{sale.name}</p>
              <p class="text-sm text-muted-foreground truncate">{sale.email}</p>
            </div>
            <div class="font-medium">{sale.amount}</div>
          </div>
        </div>
      </.card_content>
    </.card>
    """
  end

  # ── Block 5: Create Account Form ──────────────────────────────────────

  attr :plan, :string, default: "free"
  attr :terms, :boolean, default: false

  defp form_block(assigns) do
    ~H"""
    <.card>
      <.card_header>
        <.card_title>Create Account</.card_title>
        <.card_description>Enter your details to get started.</.card_description>
      </.card_header>
      <.card_content class="space-y-4">
        <div class="space-y-2">
          <.label for="demo-name">Name</.label>
          <.input type="text" id="demo-name" placeholder="Jane Doe" />
        </div>
        <div class="space-y-2">
          <.label for="demo-email">Email</.label>
          <.input type="email" id="demo-email" placeholder="jane@example.com" />
        </div>
        <div class="space-y-2">
          <.label>Role</.label>
          <.select id="demo-select-role" name="role" placeholder="Select a role" phx-hook="SelectDisplay">
            <.select_content target="demo-select-role">
              <.select_item value="admin" target="demo-select-role">Admin</.select_item>
              <.select_item value="editor" target="demo-select-role">Editor</.select_item>
              <.select_item value="viewer" target="demo-select-role">Viewer</.select_item>
            </.select_content>
          </.select>
        </div>
        <div class="space-y-3">
          <.label>Plan</.label>
          <.radio_group id="demo-plan" name="plan">
            <div class="flex items-center space-x-2">
              <.radio_group_item
                id="plan-free"
                name="plan"
                value="free"
                checked={@plan == "free"}
                phx-click="demo_select_plan"
                phx-value-value="free"
              />
              <.label for="plan-free">Free</.label>
            </div>
            <div class="flex items-center space-x-2">
              <.radio_group_item
                id="plan-pro"
                name="plan"
                value="pro"
                checked={@plan == "pro"}
                phx-click="demo_select_plan"
                phx-value-value="pro"
              />
              <.label for="plan-pro">Pro — $9/mo</.label>
            </div>
            <div class="flex items-center space-x-2">
              <.radio_group_item
                id="plan-enterprise"
                name="plan"
                value="enterprise"
                checked={@plan == "enterprise"}
                phx-click="demo_select_plan"
                phx-value-value="enterprise"
              />
              <.label for="plan-enterprise">Enterprise</.label>
            </div>
          </.radio_group>
        </div>
        <div class="flex items-center space-x-2">
          <.checkbox id="demo-terms" name="terms" checked={@terms} phx-click="demo_toggle_terms" />
          <.label for="demo-terms">Accept terms and conditions</.label>
        </div>
      </.card_content>
      <.card_footer>
        <.button class="w-full">Create account</.button>
      </.card_footer>
    </.card>
    """
  end

  # ── Block 6: Calendar ─────────────────────────────────────────────────

  attr :month, :any, default: nil
  attr :selected, :any, default: nil

  defp calendar_block(assigns) do
    ~H"""
    <.card>
      <.card_header>
        <.card_title>Calendar</.card_title>
        <.card_description>Select a date.</.card_description>
      </.card_header>
      <.card_content class="flex justify-center">
        <.calendar id="demo-calendar" selected={@selected} month={@month} />
      </.card_content>
    </.card>
    """
  end

  # ── Block 7: Invoice Table ────────────────────────────────────────────

  attr :page, :integer, default: 1

  defp table_block(assigns) do
    ~H"""
    <.card>
      <.card_header>
        <.card_title>Invoices</.card_title>
        <.card_description>Manage your recent invoices.</.card_description>
      </.card_header>
      <.card_content>
        <.table>
          <.table_header>
            <.table_row>
              <.table_head>Invoice</.table_head>
              <.table_head>Status</.table_head>
              <.table_head>Method</.table_head>
              <.table_head class="text-right">Amount</.table_head>
            </.table_row>
          </.table_header>
          <.table_body>
            <.table_row :for={inv <- mock_invoices()}>
              <.table_cell class="font-medium">{inv.id}</.table_cell>
              <.table_cell>
                <.badge variant={status_variant(inv.status)}>
                  {inv.status}
                </.badge>
              </.table_cell>
              <.table_cell>{inv.method}</.table_cell>
              <.table_cell class="text-right">{inv.amount}</.table_cell>
            </.table_row>
          </.table_body>
        </.table>
      </.card_content>
      <.card_footer class="justify-center">
        <.pagination>
          <.pagination_content>
            <.pagination_previous phx-click="demo_set_page" phx-value-page={max(@page - 1, 1)} disabled={@page == 1} />
            <.pagination_item :for={p <- 1..3}>
              <.pagination_link phx-click="demo_set_page" phx-value-page={p} active={@page == p}>
                {p}
              </.pagination_link>
            </.pagination_item>
            <.pagination_ellipsis />
            <.pagination_next phx-click="demo_set_page" phx-value-page={min(@page + 1, 3)} disabled={@page == 3} />
          </.pagination_content>
        </.pagination>
      </.card_footer>
    </.card>
    """
  end

  # ── Block 8: Buttons & Dialog ─────────────────────────────────────────

  defp interactive_block(assigns) do
    ~H"""
    <.card>
      <.card_header>
        <.card_title>Buttons</.card_title>
        <.card_description>All button variants.</.card_description>
      </.card_header>
      <.card_content class="space-y-4">
        <div class="flex flex-wrap gap-2">
          <.button variant="default">Primary</.button>
          <.button variant="secondary">Secondary</.button>
          <.button variant="outline">Outline</.button>
          <.button variant="ghost">Ghost</.button>
          <.button variant="destructive">Delete</.button>
          <.button variant="link">Link</.button>
        </div>
        <.separator />
        <div class="flex gap-2">
          <.button size="sm">Small</.button>
          <.button size="default">Default</.button>
          <.button size="lg">Large</.button>
          <.button size="icon" variant="outline">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M5 12h14"/><path d="M12 5v14"/></svg>
          </.button>
        </div>
        <.separator />
        <.dialog id="demo-dialog">
          <.dialog_trigger target="demo-dialog">
            <.button variant="outline" class="w-full">Open Dialog</.button>
          </.dialog_trigger>
          <.dialog_content target="demo-dialog">
            <.dialog_header>
              <.dialog_title>Edit Profile</.dialog_title>
              <.dialog_description>Make changes to your profile. Click save when done.</.dialog_description>
            </.dialog_header>
            <div class="space-y-4 py-4">
              <div class="space-y-2">
                <.label for="demo-dialog-name">Name</.label>
                <.input type="text" id="demo-dialog-name" value="Jane Doe" />
              </div>
              <div class="space-y-2">
                <.label for="demo-dialog-username">Username</.label>
                <.input type="text" id="demo-dialog-username" value="@janedoe" />
              </div>
            </div>
            <.dialog_footer>
              <.button phx-click={hide_dialog("demo-dialog")}>Save changes</.button>
            </.dialog_footer>
          </.dialog_content>
        </.dialog>
      </.card_content>
    </.card>
    """
  end

  # ── Block 9: Login Card ───────────────────────────────────────────────

  defp login_block(assigns) do
    ~H"""
    <.card>
      <.card_header class="text-center">
        <.card_title class="text-xl">Welcome back</.card_title>
        <.card_description>Sign in to your account</.card_description>
      </.card_header>
      <.card_content class="space-y-4">
        <div class="grid grid-cols-2 gap-2">
          <.button variant="outline">
            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" class="mr-1.5"><path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92a5.06 5.06 0 0 1-2.2 3.32v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.1z" fill="#4285F4"/><path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/><path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05"/><path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/></svg>
            Google
          </.button>
          <.button variant="outline">
            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="currentColor" class="mr-1.5"><path d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"/></svg>
            GitHub
          </.button>
        </div>
        <div class="relative">
          <div class="absolute inset-0 flex items-center">
            <.separator />
          </div>
          <div class="relative flex justify-center text-xs uppercase">
            <span class="bg-card px-2 text-muted-foreground">Or continue with</span>
          </div>
        </div>
        <div class="space-y-2">
          <.label for="login-email">Email</.label>
          <.input type="email" id="login-email" placeholder="m@example.com" />
        </div>
        <div class="space-y-2">
          <.label for="login-password">Password</.label>
          <.input type="password" id="login-password" />
        </div>
      </.card_content>
      <.card_footer class="flex-col gap-2">
        <.button class="w-full">Sign In</.button>
        <p class="text-xs text-center text-muted-foreground">
          Don't have an account?
          <a href="#" class="text-primary underline-offset-4 hover:underline">Sign up</a>
        </p>
      </.card_footer>
    </.card>
    """
  end

  # ── Block 10: Notification Settings ────────────────────────────────────

  attr :notif, :map, default: %{}

  defp notifications_block(assigns) do
    ~H"""
    <.card>
      <.card_header>
        <.card_title>Notifications</.card_title>
        <.card_description>Choose what you want to be notified about.</.card_description>
      </.card_header>
      <.card_content class="space-y-4">
        <div :for={item <- notification_items()} class="flex items-center justify-between">
          <div class="space-y-0.5">
            <.label>{item.title}</.label>
            <p class="text-xs text-muted-foreground">{item.description}</p>
          </div>
          <.switch
            id={"demo-notif-#{item.id}"}
            checked={Map.get(@notif, item.id, item.default)}
            phx-click="demo_toggle_notif"
            phx-value-id={item.id}
          />
        </div>
      </.card_content>
    </.card>
    """
  end

  # ── Block 11: Keyboard Shortcuts ──────────────────────────────────────

  defp shortcuts_block(assigns) do
    ~H"""
    <.card>
      <.card_header>
        <.card_title>Keyboard Shortcuts</.card_title>
      </.card_header>
      <.card_content>
        <div class="space-y-3">
          <div :for={shortcut <- keyboard_shortcuts()} class="flex items-center justify-between">
            <span class="text-sm text-muted-foreground">{shortcut.label}</span>
            <div class="flex gap-1">
              <.kbd :for={key <- shortcut.keys}>{key}</.kbd>
            </div>
          </div>
        </div>
      </.card_content>
    </.card>
    """
  end

  # ── Block 12: Accordion FAQ ───────────────────────────────────────────

  defp accordion_block(assigns) do
    ~H"""
    <.card>
      <.card_header>
        <.card_title>FAQ</.card_title>
      </.card_header>
      <.card_content>
        <.accordion id="demo-faq" type="single">
          <.accordion_item id="demo-faq" value="q1">
            <.accordion_trigger target="demo-faq" value="q1" type="single">
              What is Bioma?
            </.accordion_trigger>
            <.accordion_content target="demo-faq" value="q1">
              A comprehensive component library for Phoenix LiveView, inspired by shadcn/ui. Built with Tailwind CSS v4 and OKLCH colors.
            </.accordion_content>
          </.accordion_item>
          <.accordion_item id="demo-faq" value="q2">
            <.accordion_trigger target="demo-faq" value="q2" type="single">
              How does theming work?
            </.accordion_trigger>
            <.accordion_content target="demo-faq" value="q2">
              Themes use CSS custom properties with OKLCH colors. Switch presets to see all components update instantly.
            </.accordion_content>
          </.accordion_item>
          <.accordion_item id="demo-faq" value="q3">
            <.accordion_trigger target="demo-faq" value="q3" type="single">
              Can I use this in production?
            </.accordion_trigger>
            <.accordion_content target="demo-faq" value="q3">
              Yes! Install via Hex or use the CLI eject task to copy components into your project.
            </.accordion_content>
          </.accordion_item>
        </.accordion>
      </.card_content>
    </.card>
    """
  end

  # ── Block 13: Tabs ────────────────────────────────────────────────────

  defp tabs_block(assigns) do
    ~H"""
    <.card>
      <.card_header>
        <.card_title>Account Settings</.card_title>
      </.card_header>
      <.card_content>
        <.tabs id="demo-tabs" default="tab-account">
          <.tabs_list>
            <.tabs_trigger target="demo-tabs" value="tab-account">Account</.tabs_trigger>
            <.tabs_trigger target="demo-tabs" value="tab-password">Password</.tabs_trigger>
            <.tabs_trigger target="demo-tabs" value="tab-billing">Billing</.tabs_trigger>
          </.tabs_list>
          <.tabs_content target="demo-tabs" value="tab-account" default="tab-account">
            <div class="space-y-4 pt-4">
              <div class="space-y-2">
                <.label for="tab-display-name">Display Name</.label>
                <.input type="text" id="tab-display-name" value="Jane Doe" />
              </div>
              <div class="space-y-2">
                <.label for="tab-bio">Bio</.label>
                <.textarea id="tab-bio" placeholder="Tell us about yourself..." rows={3} />
              </div>
            </div>
          </.tabs_content>
          <.tabs_content target="demo-tabs" value="tab-password" default="tab-account">
            <div class="space-y-4 pt-4">
              <div class="space-y-2">
                <.label for="tab-current-pw">Current Password</.label>
                <.input type="password" id="tab-current-pw" />
              </div>
              <div class="space-y-2">
                <.label for="tab-new-pw">New Password</.label>
                <.input type="password" id="tab-new-pw" />
              </div>
              <.button>Update password</.button>
            </div>
          </.tabs_content>
          <.tabs_content target="demo-tabs" value="tab-billing" default="tab-account">
            <div class="space-y-4 pt-4">
              <div class="flex items-center justify-between">
                <div>
                  <p class="text-sm font-medium">Pro Plan</p>
                  <p class="text-sm text-muted-foreground">$9/month</p>
                </div>
                <.badge variant="secondary">Active</.badge>
              </div>
              <.separator />
              <.button variant="outline" class="w-full">Manage subscription</.button>
            </div>
          </.tabs_content>
        </.tabs>
      </.card_content>
    </.card>
    """
  end

  # ── Block 14: Alerts ──────────────────────────────────────────────────

  defp alerts_block(assigns) do
    ~H"""
    <.card>
      <.card_header>
        <.card_title>Alerts</.card_title>
      </.card_header>
      <.card_content class="space-y-3">
        <.alert>
          <.alert_title>Heads up!</.alert_title>
          <.alert_description>You can add components to your app using the CLI.</.alert_description>
        </.alert>
        <.alert variant="destructive">
          <.alert_title>Error</.alert_title>
          <.alert_description>Your session has expired. Please log in again.</.alert_description>
        </.alert>
        <.alert variant="success">
          <.alert_title>Success</.alert_title>
          <.alert_description>Your changes have been saved successfully.</.alert_description>
        </.alert>
      </.card_content>
    </.card>
    """
  end

  # ── Block 15: Progress & Loading ──────────────────────────────────────

  defp progress_block(assigns) do
    ~H"""
    <.card>
      <.card_header>
        <.card_title>Progress</.card_title>
      </.card_header>
      <.card_content class="space-y-6">
        <div class="space-y-2">
          <div class="flex justify-between text-sm">
            <span>Uploading...</span>
            <span class="text-muted-foreground">72%</span>
          </div>
          <.progress value={72} />
        </div>
        <div class="space-y-2">
          <div class="flex justify-between text-sm">
            <span>Processing...</span>
            <span class="text-muted-foreground">45%</span>
          </div>
          <.progress value={45} />
        </div>
        <.separator />
        <div class="space-y-3">
          <p class="text-sm font-medium text-muted-foreground">Loading skeleton</p>
          <div class="flex items-center gap-4">
            <.skeleton class="h-12 w-12 rounded-full" />
            <div class="space-y-2 flex-1">
              <.skeleton class="h-4 w-3/4" />
              <.skeleton class="h-4 w-1/2" />
            </div>
          </div>
        </div>
      </.card_content>
    </.card>
    """
  end

  # ── Block 16: Shipping Address ────────────────────────────────────────

  defp shipping_block(assigns) do
    ~H"""
    <.card>
      <.card_header>
        <.card_title>Shipping Address</.card_title>
        <.card_description>Enter your shipping details.</.card_description>
      </.card_header>
      <.card_content class="space-y-4">
        <div class="grid grid-cols-2 gap-4">
          <div class="space-y-2">
            <.label for="ship-first">First name</.label>
            <.input id="ship-first" placeholder="Jane" />
          </div>
          <div class="space-y-2">
            <.label for="ship-last">Last name</.label>
            <.input id="ship-last" placeholder="Doe" />
          </div>
        </div>
        <div class="space-y-2">
          <.label for="ship-address">Address</.label>
          <.textarea id="ship-address" placeholder="123 Main St, Apt 4B" rows={2} />
        </div>
        <div class="grid grid-cols-2 gap-4">
          <div class="space-y-2">
            <.label for="ship-city">City</.label>
            <.input id="ship-city" placeholder="San Francisco" />
          </div>
          <div class="space-y-2">
            <.label>Country</.label>
            <.select id="demo-country" name="country" placeholder="Select country" phx-hook="SelectDisplay">
              <.select_content target="demo-country">
                <.select_item value="us" target="demo-country">United States</.select_item>
                <.select_item value="ca" target="demo-country">Canada</.select_item>
                <.select_item value="uk" target="demo-country">United Kingdom</.select_item>
                <.select_item value="fr" target="demo-country">France</.select_item>
              </.select_content>
            </.select>
          </div>
        </div>
      </.card_content>
      <.card_footer>
        <.button class="w-full">Save address</.button>
      </.card_footer>
    </.card>
    """
  end

  # ── Block 17: Toolbar ─────────────────────────────────────────────────

  attr :bold, :boolean, default: true
  attr :italic, :boolean, default: false
  attr :underline, :boolean, default: false
  attr :align, :string, default: "left"

  defp toolbar_block(assigns) do
    ~H"""
    <.card>
      <.card_header>
        <.card_title>Toolbar</.card_title>
        <.card_description>Toggle and toggle group controls.</.card_description>
      </.card_header>
      <.card_content class="space-y-4">
        <div class="flex items-center gap-1">
          <.toggle pressed={@bold} size="sm" variant="outline" phx-click="demo_toggle" phx-value-key="bold">
            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M14 12a4 4 0 0 0 0-8H6v8"/><path d="M15 20a4 4 0 0 0 0-8H6v8"/></svg>
          </.toggle>
          <.toggle pressed={@italic} size="sm" variant="outline" phx-click="demo_toggle" phx-value-key="italic">
            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="19" x2="10" y1="4" y2="4"/><line x1="14" x2="5" y1="20" y2="20"/><line x1="15" x2="9" y1="4" y2="20"/></svg>
          </.toggle>
          <.toggle pressed={@underline} size="sm" variant="outline" phx-click="demo_toggle" phx-value-key="underline">
            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 4v6a6 6 0 0 0 12 0V4"/><line x1="4" x2="20" y1="20" y2="20"/></svg>
          </.toggle>
          <.separator orientation="vertical" class="mx-1 h-6" />
          <.toggle_group id="demo-align" type="single">
            <.toggle_group_item target="demo-align" value="left" size="sm" pressed={@align == "left"} phx-click="demo_set_align" phx-value-align="left">
              <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="21" x2="3" y1="6" y2="6"/><line x1="15" x2="3" y1="12" y2="12"/><line x1="17" x2="3" y1="18" y2="18"/></svg>
            </.toggle_group_item>
            <.toggle_group_item target="demo-align" value="center" size="sm" pressed={@align == "center"} phx-click="demo_set_align" phx-value-align="center">
              <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="21" x2="3" y1="6" y2="6"/><line x1="17" x2="7" y1="12" y2="12"/><line x1="19" x2="5" y1="18" y2="18"/></svg>
            </.toggle_group_item>
            <.toggle_group_item target="demo-align" value="right" size="sm" pressed={@align == "right"} phx-click="demo_set_align" phx-value-align="right">
              <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="21" x2="3" y1="6" y2="6"/><line x1="21" x2="9" y1="12" y2="12"/><line x1="21" x2="7" y1="18" y2="18"/></svg>
            </.toggle_group_item>
          </.toggle_group>
        </div>
        <.separator />
        <div class="space-y-2">
          <.label>Volume</.label>
          <.slider id="demo-slider" value={65} min={0} max={100} />
        </div>
      </.card_content>
    </.card>
    """
  end

  # ── Block 18: 404 / Empty State ───────────────────────────────────────

  defp empty_state_block(assigns) do
    ~H"""
    <.card>
      <.card_content class="py-12">
        <div class="flex flex-col items-center text-center">
          <div class="rounded-full bg-muted p-4">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-muted-foreground"><circle cx="12" cy="12" r="10"/><path d="M16 16s-1.5-2-4-2-4 2-4 2"/><line x1="9" x2="9.01" y1="9" y2="9"/><line x1="15" x2="15.01" y1="9" y2="9"/></svg>
          </div>
          <h3 class="mt-4 text-lg font-semibold">No results found</h3>
          <p class="mt-2 text-sm text-muted-foreground max-w-[250px]">
            We couldn't find what you're looking for. Try adjusting your search or filters.
          </p>
          <.button variant="outline" class="mt-4">Clear filters</.button>
        </div>
      </.card_content>
    </.card>
    """
  end

  # ── Block 19: Badges & Components ─────────────────────────────────────

  defp badges_block(assigns) do
    ~H"""
    <.card>
      <.card_header>
        <.card_title>Badges</.card_title>
      </.card_header>
      <.card_content class="space-y-4">
        <div class="flex flex-wrap gap-2">
          <.badge>Default</.badge>
          <.badge variant="secondary">Secondary</.badge>
          <.badge variant="outline">Outline</.badge>
          <.badge variant="destructive">Destructive</.badge>
          <.badge variant="success">Success</.badge>
          <.badge variant="warning">Warning</.badge>
        </div>
        <.separator />
        <div class="flex items-center gap-3">
          <.avatar>
            <.avatar_fallback>AB</.avatar_fallback>
          </.avatar>
          <.avatar>
            <.avatar_fallback>CD</.avatar_fallback>
          </.avatar>
          <.avatar>
            <.avatar_fallback>EF</.avatar_fallback>
          </.avatar>
          <.avatar>
            <.avatar_fallback>+3</.avatar_fallback>
          </.avatar>
        </div>
      </.card_content>
    </.card>
    """
  end

  # ── Block 20: Carousel ────────────────────────────────────────────────

  defp carousel_block(assigns) do
    slides = [
      %{
        title: "Beautiful Design",
        description: "Craft stunning interfaces with a flexible component system.",
        icon: "palette"
      },
      %{
        title: "Fully Themeable",
        description: "Customize every color, radius, and spacing token to match your brand.",
        icon: "paintbrush"
      },
      %{
        title: "Dark Mode Ready",
        description: "Seamless light and dark mode with OKLCH color tokens.",
        icon: "moon"
      },
      %{
        title: "Accessible",
        description: "ARIA roles, keyboard navigation, and screen reader support built in.",
        icon: "shield"
      },
      %{
        title: "LiveView Native",
        description: "Built for Phoenix LiveView with hooks, JS commands, and streaming.",
        icon: "bolt"
      }
    ]

    assigns = assign(assigns, :slides, slides)

    ~H"""
    <.card>
      <.card_header>
        <.card_title>Carousel</.card_title>
        <.card_description>Swipe through feature highlights.</.card_description>
      </.card_header>
      <.card_content>
        <.carousel id="demo-carousel" class="mx-6">
          <.carousel_content target="demo-carousel">
            <.carousel_item :for={slide <- @slides}>
              <div class="p-1">
                <div class="rounded-lg border bg-gradient-to-br from-primary/10 via-background to-accent/10 p-6">
                  <div class="mb-3 inline-flex h-10 w-10 items-center justify-center rounded-lg bg-primary/15">
                    <.carousel_icon name={slide.icon} />
                  </div>
                  <h3 class="mb-1.5 text-lg font-semibold tracking-tight">{slide.title}</h3>
                  <p class="text-sm text-muted-foreground leading-relaxed">{slide.description}</p>
                </div>
              </div>
            </.carousel_item>
          </.carousel_content>
          <.carousel_previous target="demo-carousel" />
          <.carousel_next target="demo-carousel" />
          <.carousel_indicators target="demo-carousel" count={length(@slides)} />
        </.carousel>
      </.card_content>
    </.card>
    """
  end

  defp carousel_icon(%{name: "palette"} = assigns) do
    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-primary">
      <circle cx="13.5" cy="6.5" r=".5" fill="currentColor" /><circle cx="17.5" cy="10.5" r=".5" fill="currentColor" /><circle cx="8.5" cy="7.5" r=".5" fill="currentColor" /><circle cx="6.5" cy="12.5" r=".5" fill="currentColor" /><path d="M12 2C6.5 2 2 6.5 2 12s4.5 10 10 10c.926 0 1.648-.746 1.648-1.688 0-.437-.18-.835-.437-1.125-.29-.289-.438-.652-.438-1.125a1.64 1.64 0 0 1 1.668-1.668h1.996c3.051 0 5.555-2.503 5.555-5.554C21.965 6.012 17.461 2 12 2z" />
    </svg>
    """
  end

  defp carousel_icon(%{name: "paintbrush"} = assigns) do
    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-primary">
      <path d="m14.622 17.897-10.68-2.913" /><path d="M18.376 2.622a1 1 0 1 1 3.002 3.002L17.36 9.643a.5.5 0 0 0 0 .707l.944.944a2.41 2.41 0 0 1 0 3.408l-.944.944a.5.5 0 0 1-.707 0L8.354 7.348a.5.5 0 0 1 0-.707l.944-.944a2.41 2.41 0 0 1 3.408 0l.944.944a.5.5 0 0 0 .707 0z" /><path d="M9 8c-1.804 2.71-3.97 3.46-6.583 3.948a.507.507 0 0 0-.302.819l7.32 8.883a1 1 0 0 0 1.185.204C12.735 20.405 16 16.792 16 15" />
    </svg>
    """
  end

  defp carousel_icon(%{name: "moon"} = assigns) do
    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-primary">
      <path d="M12 3a6 6 0 0 0 9 9 9 9 0 1 1-9-9Z" />
    </svg>
    """
  end

  defp carousel_icon(%{name: "shield"} = assigns) do
    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-primary">
      <path d="M20 13c0 5-3.5 7.5-7.66 8.95a1 1 0 0 1-.67-.01C7.5 20.5 4 18 4 13V6a1 1 0 0 1 1-1c2 0 4.5-1.2 6.24-2.72a1.17 1.17 0 0 1 1.52 0C14.51 3.81 17 5 19 5a1 1 0 0 1 1 1z" /><path d="m9 12 2 2 4-4" />
    </svg>
    """
  end

  defp carousel_icon(%{name: "bolt"} = assigns) do
    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-primary">
      <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z" /><circle cx="12" cy="12" r="4" />
    </svg>
    """
  end

  # ── Mock data ─────────────────────────────────────────────────────────

  defp mock_sales do
    [
      %{name: "Olivia Martin", email: "olivia@example.com", amount: "+$1,999.00", initials: "OM"},
      %{name: "Jackson Lee", email: "jackson@example.com", amount: "+$39.00", initials: "JL"},
      %{name: "Isabella Nguyen", email: "isabella@example.com", amount: "+$299.00", initials: "IN"},
      %{name: "William Kim", email: "will@example.com", amount: "+$99.00", initials: "WK"},
      %{name: "Sofia Davis", email: "sofia@example.com", amount: "+$450.00", initials: "SD"}
    ]
  end

  defp mock_invoices do
    [
      %{id: "INV001", status: "Paid", method: "Credit Card", amount: "$250.00"},
      %{id: "INV002", status: "Pending", method: "PayPal", amount: "$150.00"},
      %{id: "INV003", status: "Paid", method: "Bank Transfer", amount: "$350.00"},
      %{id: "INV004", status: "Failed", method: "Credit Card", amount: "$450.00"},
      %{id: "INV005", status: "Pending", method: "PayPal", amount: "$550.00"}
    ]
  end

  defp status_variant("Paid"), do: "default"
  defp status_variant("Pending"), do: "secondary"
  defp status_variant("Failed"), do: "destructive"
  defp status_variant(_), do: "outline"

  defp notification_items do
    [
      %{id: "push", title: "Push Notifications", description: "Receive push notifications on your device.", default: true},
      %{id: "email", title: "Email Notifications", description: "Receive email notifications for updates.", default: true},
      %{id: "marketing", title: "Marketing Emails", description: "Receive emails about new products and features.", default: false},
      %{id: "security", title: "Security Alerts", description: "Get notified about security events.", default: true}
    ]
  end

  defp keyboard_shortcuts do
    [
      %{label: "Search", keys: ["⌘", "K"]},
      %{label: "Bold", keys: ["⌘", "B"]},
      %{label: "Italic", keys: ["⌘", "I"]},
      %{label: "Save", keys: ["⌘", "S"]},
      %{label: "Undo", keys: ["⌘", "Z"]},
      %{label: "Select All", keys: ["⌘", "A"]}
    ]
  end

  # ── Block 21: Tree View ────────────────────────────────────────────────

  attr :class, :string, default: nil

  defp tree_view_block(assigns) do
    ~H"""
    <.card>
      <.card_header>
        <.card_title>Tree View</.card_title>
        <.card_description>File browser — expand/collapse folders.</.card_description>
      </.card_header>
      <.card_content>
        <.tree id="demo-tree" class="border rounded-md p-2 bg-muted/20">
          <.tree_node id="dt-src" label="src" expanded>
            <:icon>
              <svg class="h-4 w-4 text-amber-500" viewBox="0 0 24 24" fill="currentColor">
                <path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z" />
              </svg>
            </:icon>
            <.tree_node id="dt-atoms" label="atoms" expanded>
              <:icon>
                <svg class="h-4 w-4 text-amber-500" viewBox="0 0 24 24" fill="currentColor">
                  <path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z" />
                </svg>
              </:icon>
              <.tree_node id="dt-button" label="button.ex" selected>
                <:icon>
                  <svg class="h-4 w-4 text-muted-foreground" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M14.5 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7.5L14.5 2z" />
                    <polyline points="14 2 14 8 20 8" />
                  </svg>
                </:icon>
              </.tree_node>
              <.tree_node id="dt-input" label="input.ex">
                <:icon>
                  <svg class="h-4 w-4 text-muted-foreground" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M14.5 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7.5L14.5 2z" />
                    <polyline points="14 2 14 8 20 8" />
                  </svg>
                </:icon>
              </.tree_node>
              <.tree_node id="dt-badge" label="badge.ex">
                <:icon>
                  <svg class="h-4 w-4 text-muted-foreground" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M14.5 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7.5L14.5 2z" />
                    <polyline points="14 2 14 8 20 8" />
                  </svg>
                </:icon>
              </.tree_node>
            </.tree_node>
            <.tree_node id="dt-molecules" label="molecules">
              <:icon>
                <svg class="h-4 w-4 text-amber-500" viewBox="0 0 24 24" fill="currentColor">
                  <path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z" />
                </svg>
              </:icon>
              <.tree_node id="dt-card" label="card.ex">
                <:icon>
                  <svg class="h-4 w-4 text-muted-foreground" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M14.5 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7.5L14.5 2z" />
                    <polyline points="14 2 14 8 20 8" />
                  </svg>
                </:icon>
              </.tree_node>
              <.tree_node id="dt-tree" label="tree.ex">
                <:icon>
                  <svg class="h-4 w-4 text-muted-foreground" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M14.5 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7.5L14.5 2z" />
                    <polyline points="14 2 14 8 20 8" />
                  </svg>
                </:icon>
              </.tree_node>
            </.tree_node>
          </.tree_node>
          <.tree_node id="dt-mix" label="mix.exs">
            <:icon>
              <svg class="h-4 w-4 text-muted-foreground" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M14.5 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7.5L14.5 2z" />
                <polyline points="14 2 14 8 20 8" />
              </svg>
            </:icon>
          </.tree_node>
        </.tree>
      </.card_content>
    </.card>
    """
  end

  # ── Block 22: Markdown Editor ─────────────────────────────────────────

  attr :markdown, :string, default: ""
  attr :preview_html, :string, default: nil

  defp markdown_editor_block(assigns) do
    ~H"""
    <.card>
      <.card_header>
        <.card_title>Markdown Editor</.card_title>
        <.card_description>Toolbar formatting · Split/preview modes · Live preview via phx-change.</.card_description>
      </.card_header>
      <.card_content>
        <.markdown_editor
          id="demo-md-editor"
          name="demo_markdown"
          value={@markdown}
          preview_html={@preview_html}
          mode="split"
          rows={8}
          phx-change="demo_markdown_change"
          phx-debounce="300"
        />
      </.card_content>
    </.card>
    """
  end

  # ── Block 23: Kanban Board ────────────────────────────────────────────

  defp kanban_board_block(assigns) do
    ~H"""
    <.card>
      <.card_header>
        <.card_title>Kanban Board</.card_title>
        <.card_description>Drag cards between columns. Fires <code class="text-xs bg-muted px-1 py-0.5 rounded">kanban_card_moved</code> LiveView events.</.card_description>
      </.card_header>
      <.card_content class="overflow-x-auto">
        <.kanban id="demo-kanban">
          <.kanban_column id="kb-backlog" title="Backlog" count={3}>
            <.kanban_card id="kb-c1" title="Design system audit" label="Design" priority="low" />
            <.kanban_card
              id="kb-c2"
              title="Set up CI/CD pipeline"
              label="Infra"
              description="GitHub Actions with Elixir + Docker."
              priority="medium"
              assignee="AR"
            />
            <.kanban_card id="kb-c3" title="Write onboarding docs" label="Docs" />
          </.kanban_column>

          <.kanban_column id="kb-progress" title="In Progress" count={2}>
            <.kanban_card
              id="kb-c4"
              title="Build Kanban component"
              label="Feature"
              priority="high"
              description="Native HTML5 DnD, no external deps."
              assignee="VM"
            />
            <.kanban_card
              id="kb-c5"
              title="Markdown editor"
              label="Feature"
              priority="medium"
              assignee="VM"
            />
          </.kanban_column>

          <.kanban_column id="kb-review" title="Review" count={1}>
            <.kanban_card
              id="kb-c6"
              title="Tree view component"
              label="Feature"
              priority="low"
              assignee="AR"
            />
          </.kanban_column>

          <.kanban_column id="kb-done" title="Done" count={2}>
            <.kanban_card id="kb-c7" title="Initial scaffolding" label="Infra" />
            <.kanban_card id="kb-c8" title="Tailwind v4 theme" label="Design" />
          </.kanban_column>
        </.kanban>
      </.card_content>
    </.card>
    """
  end
end
