defmodule NervesHubDevice do
  @doc """
  Checks if the device is connected to the NervesHub channel.
  """
  @spec connected? :: boolean()
  def connected?() do
    channel_state()
    |> Map.get(:connected?, false)
  end

  @doc """
  Current status of the device channel
  """
  @spec status :: NervesHubDevice.Channel.State.status()
  def status() do
    channel_state()
    |> Map.get(:status, :unknown)
  end

  defp channel_state() do
    GenServer.whereis(NervesHubDevice.Channel)
    |> case do
      channel when is_pid(channel) -> GenServer.call(channel, :get_state)
      _ -> %{}
    end
  end
end
